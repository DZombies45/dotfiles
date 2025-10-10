#!/data/data/com.termux/files/usr/bin/bash
set -e

# ============================================
# 🔧 CONFIG DEFAULT
# ============================================
project_name=$(basename "$PWD")
target_dir=~/storage/downloads/Termux/mc-$project_name
src_dir="./src"
out_dir="./out"
script_dir="./script"
esbuild_script="./esbuild.js"

skip_tsc=false
skip_prettier=false
skip_esbuild=false
dry_run=false

# ============================================
# 🧭 PARSE ARGUMEN
# ============================================
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --skip-tsc) skip_tsc=true ;;
    --skip-prettier) skip_prettier=true ;;
    --skip-esbuild) skip_esbuild=true ;;
    --target) shift; target_dir="$1" ;;
    --dry-run) dry_run=true ;;
    -h|--help)
      echo "🪶 mc-export - Export Minecraft Script Project"
      echo
      echo "Usage: mc-export [options]"
      echo
      echo "Options:"
      echo "  --skip-tsc        Lewati kompilasi TypeScript"
      echo "  --skip-prettier   Lewati format file dengan Prettier"
      echo "  --skip-esbuild    Lewati bundling esbuild"
      echo "  --target <path>   Ganti folder target ekspor"
      echo "  --dry-run         Coba tanpa menyalin apapun"
      echo "  -h, --help        Tampilkan bantuan ini"
      exit 0 ;;
  esac
  shift
done

# ============================================
# 🏗️ BUILD PROSES
# ============================================
echo "🚀 Exporting project: $project_name"
echo "📂 Target: $target_dir"

if [ "$dry_run" = true ]; then
  echo "⚠️ Dry run mode aktif — tidak ada file yang akan disalin."
fi

# Bersihkan build lama
if [ "$skip_tsc" = false ]; then
  echo "🧹 Membersihkan dan membangun TypeScript..."
  rm -rf "$out_dir"
  [ "$dry_run" = false ] && tsc
else
  echo "⏩ Melewati TSC build"
fi

if [ "$skip_prettier" = false ]; then
  echo "🎨 Menjalankan Prettier..."
  [ "$dry_run" = false ] && npx prettier --write "**/*.js"
else
  echo "⏩ Melewati Prettier"
fi

if [ "$skip_esbuild" = false ]; then
  if [ -f "$esbuild_script" ]; then
    echo "⚙️  Menjalankan esbuild..."
    [ "$dry_run" = false ] && node "$esbuild_script"
  else
    echo "⚠️ Tidak ditemukan $esbuild_script — dilewati."
  fi
else
  echo "⏩ Melewati esbuild"
fi

# ============================================
# 📦 EKSPOR FILE KE TARGET
# ============================================
mkdir -p "$target_dir"

sync_folder() {
  local src="$1"
  local dest="$2"
  if [ -d "$src" ]; then
    echo "📁 Sync: $src -> $dest"
    [ "$dry_run" = false ] && rsync -av --delete \
      --exclude '.git' \
      --exclude 'node_modules' \
      --exclude '.env' \
      "$src"/ "$dest"/
  else
    echo "⚠️ Folder tidak ditemukan: $src"
  fi
}

sync_folder "$src_dir" "$target_dir/src"
sync_folder "$out_dir" "$target_dir/out"
sync_folder "$script_dir" "$target_dir/script"

# ============================================
# ✅ SELESAI
# ============================================
if [ "$dry_run" = false ]; then
  termux-toast "Export $project_name selesai"
fi
echo "✅ Export selesai untuk $project_name"
