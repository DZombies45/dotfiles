#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
# 📦 mc-copy.sh — Copy satu folder ke target otomatis (rsync progress bawaan)
# ============================================================

set -e

# --- Argumen ---
if [ $# -lt 1 ]; then
  echo "⚙️  Usage: mc-copy.sh <source_folder>"
  echo "   contoh: mc-copy.sh script"
  exit 1
fi

src="$1"
project_name=$(basename "$PWD")
target_dir="$HOME/storage/shared/Android/data/com.mojang.minecraftpe/files/games/com.mojang/mc-$project_name/$src"

echo "🚀 Menyalin folder proyek: $project_name"
echo "📂 Dari : $PWD/$src"
echo "📦 Ke   : $target_dir"
echo

mkdir -p "$target_dir"

# --- Menyalin dengan rsync + progress real ---
rsync -avh --delete --info=progress2 \
  --exclude 'node_modules' \
  --exclude '.git' \
  --exclude '.env' \
  --exclude '*.log' \
  "$src/" "$target_dir/"

echo -e "\n✅ Selesai: $target_dir"
termux-toast "Folder $src disalin ke mc-$project_name!"