#!/data/data/com.termux/files/usr/bin/bash

# === Konfigurasi ===
SOURCE="/storage/emulated/0/Android/data/com.mojang.minecraftpe/files/games/com.mojang"
DEST_BASE="/storage/emulated/0/Documents/mc-backup"
MAX_BACKUP=10

# === Path masing-masing kategori ===
BEHAVIOR_PATHS=("development_behavior_packs" "behavior_packs")
RESOURCE_PATHS=("development_resource_packs" "resource_packs")
WORLD_PATHS=("minecraftWorlds" "world_templates")

# === Fungsi notifikasi ===
notify() {
    termux-notification \
        --title "$1" \
        --content "$2" \
        --priority high \
        --sound
}

# === Fungsi untuk salin folder jika ada ===
copy_if_exists() {
    local folder="$1"
    local dest_folder="$2"
    if [[ -d "$SOURCE/$folder" ]]; then
        cp -r "$SOURCE/$folder" "$dest_folder/"
        echo "📦 $folder disalin"
    else
        echo "⚠️  $folder tidak ditemukan, dilewati"
    fi
}

# === Fungsi backup sesuai kategori ===
backup() {
    local category="$1"
    local zip="$2"

    local dest="$DEST_BASE/$category"
    mkdir -p "$dest"

    DATE=$(date +"%Y-%m-%d_%H-%M")
    BACKUP_FOLDER="$dest/backup_$DATE"

    mkdir -p "$BACKUP_FOLDER"

    case "$category" in
        behavior)
            for folder in "${BEHAVIOR_PATHS[@]}"; do
                copy_if_exists "$folder" "$BACKUP_FOLDER"
            done
            ;;
        resource)
            for folder in "${RESOURCE_PATHS[@]}"; do
                copy_if_exists "$folder" "$BACKUP_FOLDER"
            done
            ;;
        world)
            for folder in "${WORLD_PATHS[@]}"; do
                copy_if_exists "$folder" "$BACKUP_FOLDER"
            done
            ;;
        other)
            for item in "$SOURCE"/*; do
                base=$(basename "$item")
                skip=0
                for f in "${BEHAVIOR_PATHS[@]}" "${RESOURCE_PATHS[@]}" "${WORLD_PATHS[@]}"; do
                    if [[ "$base" == "$f" ]]; then
                        skip=1
                        break
                    fi
                done
                if (( skip == 0 )); then
                    cp -r "$item" "$BACKUP_FOLDER/"
                    echo "📦 $base disalin (other)"
                fi
            done
            ;;
        all)
            cp -r "$SOURCE"/* "$BACKUP_FOLDER/"
            echo "📦 Semua data Minecraft disalin"
            ;;
    esac

    # === Jika pilih zip ===
    if [[ "$zip" == "yes" ]]; then
        (cd "$dest" && zip -r "backup_$DATE.zip" "backup_$DATE" >/dev/null)
        rm -rf "$BACKUP_FOLDER"
        echo "🗜️  Backup dikompres ke backup_$DATE.zip"
        notify "Backup $category ZIP" "Backup ZIP berhasil: $DATE"
    else
        echo "✅ Backup selesai: $BACKUP_FOLDER"
        notify "Backup $category" "Backup folder selesai: $DATE"
    fi

    # === Hapus backup lama (per kategori) ===
    cd "$dest" || { notify "Backup Error" "Gagal akses folder $dest"; exit 1; }

    BACKUPS=($(ls -1d backup_* 2>/dev/null | sort))
    ZIPS=($(ls -1 *.zip 2>/dev/null | sort))
    TOTAL=$(( ${#BACKUPS[@]} + ${#ZIPS[@]} ))

    if (( TOTAL > MAX_BACKUP )); then
        TO_DELETE=$(( TOTAL - MAX_BACKUP ))
        echo "🧹 Terlalu banyak backup ($TOTAL), menghapus $TO_DELETE paling lama..."

        for ((i=0; i<TO_DELETE; i++)); do
            if [[ ${BACKUPS[$i]} ]]; then
                echo "🔻 Menghapus folder: ${BACKUPS[$i]}"
                rm -rf "${BACKUPS[$i]}"
            elif [[ ${ZIPS[$i]} ]]; then
                echo "🔻 Menghapus zip: ${ZIPS[$i]}"
                rm -f "${ZIPS[$i]}"
            fi
        done
    else
        echo "ℹ️ Total backup sekarang: $TOTAL (maksimum: $MAX_BACKUP)"
    fi
}

# === Menu Interaktif ===
echo "=== Minecraft Backup ==="
PS3="Pilih opsi backup: "

options=("Behavior Pack" "Resource Pack" "World" "Other" "All" "Keluar")
select opt in "${options[@]}"
do
    case $REPLY in
        1) CATEGORY="behavior";;
        2) CATEGORY="resource";;
        3) CATEGORY="world";;
        4) CATEGORY="other";;
        5) CATEGORY="all";;
        6) echo "🚪 Keluar."; exit 0;;
        *) echo "❗ Pilihan tidak valid."; continue;;
    esac

    # === Tanyakan kompresi ===
    echo -n "Kompres ke zip? (y/n): "
    read answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        ZIP="yes"
    else
        ZIP="no"
    fi

    backup "$CATEGORY" "$ZIP"
    break
done