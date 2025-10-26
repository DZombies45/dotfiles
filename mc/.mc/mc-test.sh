#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
# 🚀 mc-export.sh — Build (opsional) + Export folder fleksibel
# ============================================================

set -e

# --- Default ---
export_folder="scripts"
run_build=true
project_name=$(basename "$PWD")
project_name=${project_name#mc-}          # hapus prefix mc- jika ada
target_dir="$HOME/storage/shared/Android/data/com.mojang.minecraftpe/files/games/com.mojang/development_behavior_packs/_$project_name/$export_folder"


# --- Parsing argumen ---
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --no-build)
      run_build=false
      ;;
    --folder)
      export_folder="$2"
      shift
      ;;
    --to)
      target_dir="$2"
      shift
      ;;
    *)
      echo "❌ Argumen tidak dikenal: $1"
      echo "   Gunakan: mc-test [--no-build] [--folder <nama_folder>] [--to <target_dir>]"
      exit 1
      ;;
  esac
  shift
done

# --- Deteksi proyek dan target ---
echo "🚀 Exporting folder: '$export_folder'"
echo "📦 Project: $project_name"
echo "📂 Target: $target_dir"
echo

# --- Jalankan build (jika tidak di-skip) ---
if [ "$run_build" = true ]; then
  echo "🧹 Menjalankan TypeScript compiler (tsc)..."
  if ! npx tsc; then
    echo "❌ Gagal menjalankan tsc"
    exit 1
  fi
  echo "✅ TypeScript build selesai"
  echo

  echo "⚙️  Menjalankan bundler (esbuild.js)..."
  if ! node esbuild.js; then
    echo "❌ Gagal menjalankan esbuild"
    exit 1
  fi
  echo "✅ Bundling selesai"
  echo
else
  echo "⏭️  Melewati tahap build (--no-build aktif)"
  echo
fi

# --- Pastikan folder ada ---
if [ ! -d "$export_folder" ]; then
  echo "❌ Folder '$export_folder' tidak ditemukan!"
  exit 1
fi

mkdir -p "$target_dir"

# --- Sinkronisasi ---
echo "📂 Menyalin folder '$export_folder/' ke target..."
rsync -avh --delete --info=progress2 \
  --exclude 'node_modules' \
  --exclude '.git' \
  --exclude '.env' \
  --exclude '*.log' \
  "$export_folder"/ "$target_dir/"

echo
echo "🎉 Export folder '$export_folder' selesai: $target_dir"
termux-toast "Export $export_folder project $project_name selesai!"