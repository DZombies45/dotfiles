#!/data/data/com.termux/files/usr/bin/bash
# ==============================================
# Minecraft Bedrock Backup Script (Termux)
# Dengan Progress Bar & Toast Notification
# ==============================================

set -euo pipefail

# ===== Konfigurasi =====
readonly SOURCE="/storage/emulated/0/Android/data/com.mojang.minecraftpe/files/games/com.mojang"
readonly DEST_BASE="/storage/emulated/0/Documents/mc-backup"
readonly MAX_BACKUP=10
readonly LOGFILE="$DEST_BASE/backup.log"

# Kategori folder Minecraft
BEHAVIOR_PATHS=("development_behavior_packs" "behavior_packs")
RESOURCE_PATHS=("development_resource_packs" "resource_packs")
WORLD_PATHS=("minecraftWorlds" "world_templates")

# Folder yang dikecualikan (opsional)
EXCLUDE_LIST=("logs" "cache")

# ===== Fungsi Logging =====
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" >> "$LOGFILE"
}

# ===== Fungsi Output =====
info()    { echo -e "ℹ️  \033[1;34m$1\033[0m"; }
success() { echo -e "✅ \033[1;32m$1\033[0m"; }
warn()    { echo -e "⚠️  \033[1;33m$1\033[0m"; }
error()   { echo -e "❌ \033[1;31m$1\033[0m"; }

# ===== Toast Notification =====
toast() {
    termux-toast "$1"
}

# ===== Cek Exclude =====
is_excluded() {
    local name="$1"
    for ex in "${EXCLUDE_LIST[@]}"; do
        [[ "$name" == "$ex" ]] && return 0
    done
    return 1
}

# ===== Fungsi Salin Folder dengan Progress =====
copy_with_progress() {
    local src="$1"
    local dest="$2"

    rsync -a --info=progress2 "$src" "$dest" \
        | awk '/to-check/ {printf "\r📂 Menyalin... %s", $0}' \
        || { error "Gagal menyalin $src"; exit 1; }
    echo
}

# ===== Fungsi Backup =====
backup() {
    local category="$1"
    local zip="$2"

    local dest="$DEST_BASE/$category"
    mkdir -p "$dest"

    DATE=$(date +"%Y-%m-%d_%H-%M")
    BACKUP_FOLDER="$dest/backup_$DATE"
    mkdir -p "$BACKUP_FOLDER"

    info "Mulai backup kategori: $category"
    toast "Backup $category dimulai..."

    # === Backup berdasarkan kategori ===
    case "$category" in
        behavior)
            for folder in "${BEHAVIOR_PATHS[@]}"; do
                [[ -d "$SOURCE/$folder" ]] \
                    && copy_with_progress "$SOURCE/$folder" "$BACKUP_FOLDER/" \
                    || warn "$folder tidak ditemukan, dilewati"
            done
            ;;
        resource)
            for folder in "${RESOURCE_PATHS[@]}"; do
                [[ -d "$SOURCE/$folder" ]] \
                    && copy_with_progress "$SOURCE/$folder" "$BACKUP_FOLDER/" \
                    || warn "$folder tidak ditemukan, dilewati"
            done
            ;;
        world)
            for folder in "${WORLD_PATHS[@]}"; do
                [[ -d "$SOURCE/$folder" ]] \
                    && copy_with_progress "$SOURCE/$folder" "$BACKUP_FOLDER/" \
                    || warn "$folder tidak ditemukan, dilewati"
            done
            ;;
        other)
            for item in "$SOURCE"/*; do
                base=$(basename "$item")
                skip=0
                for f in "${BEHAVIOR_PATHS[@]}" "${RESOURCE_PATHS[@]}" "${WORLD_PATHS[@]}"; do
                    [[ "$base" == "$f" ]] && skip=1 && break
                done
                is_excluded "$base" && skip=1
                (( skip == 0 )) && copy_with_progress "$item" "$BACKUP_FOLDER/"
            done
            ;;
        all)
            copy_with_progress "$SOURCE/" "$BACKUP_FOLDER/"
            ;;
        *)
            error "Kategori tidak dikenal: $category"
            exit 1
            ;;
    esac

    # === Kompres jika ZIP dipilih ===
    if [[ "$zip" == "yes" ]]; then
        info "Mengompres backup ke ZIP (dengan progress)..."
        {
            cd "$dest"
            # Hitung total size untuk progress bar
            TOTAL_SIZE=$(du -sb "backup_$DATE" | awk '{print $1}')
            tar -cf - "backup_$DATE" | pv -s "$TOTAL_SIZE" | pigz > "backup_$DATE.zip"
            rm -rf "backup_$DATE"
        }
        SIZE=$(du -sh "$dest/backup_$DATE.zip" | cut -f1)
        success "Backup dikompres ke backup_$DATE.zip ($SIZE)"
        toast "Backup $category ZIP selesai ($SIZE)"
        log "Backup $category ZIP selesai, ukuran: $SIZE"
    else
        SIZE=$(du -sh "$BACKUP_FOLDER" | cut -f1)
        success "Backup selesai di folder: $BACKUP_FOLDER ($SIZE)"
        toast "Backup $category selesai ($SIZE)"
        log "Backup $category folder selesai, ukuran: $SIZE"
    fi

    cleanup_old_backups "$dest"
}

# ===== Fungsi Hapus Backup Lama =====
cleanup_old_backups() {
    local dest="$1"

    mapfile -t BACKUPS < <(find "$dest" -maxdepth 1 -type d -name "backup_*" | sort)
    mapfile -t ZIPS < <(find "$dest" -maxdepth 1 -type f -name "*.zip" | sort)

    local TOTAL=$(( ${#BACKUPS[@]} + ${#ZIPS[@]} ))

    if (( TOTAL > MAX_BACKUP )); then
        local TO_DELETE=$(( TOTAL - MAX_BACKUP ))
        warn "Menghapus $TO_DELETE backup lama..."

        local ALL_BACKUPS=("${BACKUPS[@]}" "${ZIPS[@]}")
        IFS=$'\n' sorted=($(sort <<<"${ALL_BACKUPS[*]}"))
        unset IFS

        for ((i=0; i<TO_DELETE; i++)); do
            target="${sorted[$i]}"
            [[ -d "$target" ]] && rm -rf "$target" || rm -f "$target"
            info "Menghapus: $target"
        done
    else
        info "Total backup sekarang: $TOTAL (maksimum: $MAX_BACKUP)"
    fi
}

# ===== Menu Interaktif FZF =====
menu_interaktif() {
    local options=("behavior" "resource" "world" "other" "all" "keluar")
    CATEGORY=$(printf "%s\n" "${options[@]}" | fzf --prompt "Pilih backup: ")

    [[ "$CATEGORY" == "keluar" || -z "$CATEGORY" ]] && { info "Keluar."; exit 0; }

    read -p "Kompres ke zip? (Y/n): " answer
    if [[ "$answer" =~ ^[Nn]$ ]]; then
        ZIP="no"
    else
        ZIP="yes"
    fi

    backup "$CATEGORY" "$ZIP"
}

# ===== Mode CLI =====
if [[ $# -ge 1 ]]; then
    CATEGORY="$1"
    ZIP="${2:-no}"
    backup "$CATEGORY" "$ZIP"
    exit 0
fi

# ===== Jalankan Menu =====
menu_interaktif