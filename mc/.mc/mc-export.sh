#!/data/data/com.termux/files/usr/bin/bash
# mc-export (Termux) — with npx + spinner + progress
set -e

# ------------ config & args -------------
project_name=$(basename "$PWD")
project_name=${project_name#mc-}          # hapus prefix mc- jika ada
target_dir="$HOME/storage/downloads/Termux/mc-$project_name"
src_dir="./src"
out_dir="./out"
script_dir="./script"
esbuild_script="./esbuild.js"

skip_tsc=false
skip_prettier=false
skip_esbuild=false
dry_run=false

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --skip-tsc) skip_tsc=true ;;
    --skip-prettier) skip_prettier=true ;;
    --skip-esbuild) skip_esbuild=true ;;
    --target) shift; target_dir="$1" ;;
    --dry-run) dry_run=true ;;
    -h|--help)
      cat <<EOF
Usage: mc-export [options]

Options:
  --skip-tsc        Skip TypeScript compilation
  --skip-prettier   Skip Prettier formatting
  --skip-esbuild    Skip esbuild bundling
  --target <path>   Override export target dir
  --dry-run         Show actions but don't copy
  -h, --help        Show this help
EOF
      exit 0 ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
  shift
done

echo "🚀 Exporting project: mc-$project_name"
echo "📂 Target: $target_dir"
[ "$dry_run" = true ] && echo "⚠️ Dry-run mode (no file changes)"

# ---------------- helpers ----------------
progress() {
  local percent=$1 bar_size=30
  local filled=$(( (percent * bar_size) / 100 ))
  local empty=$(( bar_size - filled ))
  printf "\r["
  for ((i=0;i<filled;i++)); do printf "█"; done
  for ((i=0;i<empty;i++)); do printf " "; done
  printf "] %3d%%" "$percent"
}

run_step() {
  local label="$1"; shift
  local cmd="$*"
  local tmp=$(mktemp)
  local percent=0
  local spin=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local speed=$(( (RANDOM % 3) + 1 ))

  bash -lc "$cmd" >"$tmp" 2>&1 & pid=$!

  while kill -0 "$pid" 2>/dev/null; do
    for s in "${spin[@]}"; do
      percent=$((percent + speed))
      [ $percent -gt 95 ] && percent=95
      printf "\r%s %s " "$s" "$label"
      progress "$percent"
      sleep 0.12
      if ! kill -0 "$pid" 2>/dev/null; then break 2; fi
    done
  done

  wait "$pid"
  local status=$?
  if [ $status -ne 0 ]; then
    printf "\n✖ %s gagal (exit %d)\n" "$label" "$status"
    tail -n 50 "$tmp"
    rm -f "$tmp"
    exit $status
  fi
  progress 100
  printf "  ✅ %s selesai\n" "$label"
  rm -f "$tmp"
}

# ---------------- determine steps ----------------
steps=0
[ "$skip_tsc" = false ] && steps=$((steps+1))
[ "$skip_prettier" = false ] && steps=$((steps+1))
[ "$skip_esbuild" = false ] && steps=$((steps+1))
steps=$((steps+1))  # +1 for sync
total_steps=$steps
current_step=0

# ---------------- 1) TypeScript (via npx) ----------------
if [ "$skip_tsc" = false ]; then
  current_step=$((current_step+1))
  progress $((current_step-1)) $total_steps
  echo
  # prefer local tsc (npx --no-install), fallback to npx (remote), fallback to global tsc
  run_step "Building TypeScript (tsc)" \
    "npx tsc"
  progress $current_step $total_steps
fi

# ---------------- 2) Prettier (via npx) ----------------
if [ "$skip_prettier" = false ]; then
  current_step=$((current_step+1))
  progress $((current_step-1)) $total_steps
  echo
  run_step "Formatting (Prettier)" \
    "npx prettier --write \"**/*.js\""
  progress $current_step $total_steps
fi

# ---------------- 3) esbuild ----------------
if [ "$skip_esbuild" = false ]; then
  current_step=$((current_step+1))
  progress $((current_step-1)) $total_steps
  echo
  if [ -f "$esbuild_script" ]; then
    run_step "Bundling (esbuild)" "node \"$esbuild_script\""
  else
    echo "⚠️ esbuild script tidak ditemukan: $esbuild_script — melewati"
  fi
  progress $current_step $total_steps
fi

# ---------------- 4) Sync (rsync) ----------------
current_step=$((current_step+1))
progress $((current_step-1)) $total_steps
echo
mkdir -p "$target_dir"
SYNC_CMD="rsync -a --delete --exclude 'node_modules' --exclude '.git' --exclude '.env' --exclude '*.log' ./ \"$target_dir\"/"
run_step "Syncing files to target" "$SYNC_CMD"
progress $current_step $total_steps

# final newline & toast
echo
termux-toast "Export mc-$project_name selesai" 2>/dev/null || true
echo "🎉 Export selesai: $target_dir"
