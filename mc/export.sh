#!/data/data/com.termux/files/usr/bin/bash
set -e

# ambil nama folder project (misal mc-daycycletuner)
project_name=$(basename "$PWD")
target_dir=~/storage/downloads/Termux/$project_name

# 1️⃣ Bersihkan & build ulang
echo "🧹 Membersihkan dan build TypeScript..."
rm -rf out script
tsc
npx prettier --write "**/*.js"

echo "⚙️  Menjalankan esbuild..."
node esbuild.js

# 2️⃣ Pastikan folder target ada
mkdir -p "$target_dir"

# 3️⃣ Sinkronisasi pakai rsync
echo "📦 Menyalin hasil build ke $target_dir ..."
rsync -av --delete --exclude '.git' --exclude 'node_modules' --exclude '.env' src/ "$target_dir/src/"
rsync -av --delete out/ "$target_dir/out/"
rsync -av --delete script/ "$target_dir/script/"

# 4️⃣ Notifikasi selesai
termux-toast "Export $project_name selesai"
echo "✅ Export selesai untuk $project_name"
