#!/data/data/com.termux/files/usr/bin/bash
# mc-export (Termux) — with npx + spinner + progress
set -e

# ------------ config & args -------------
project_name=$(basename "$PWD")
project_name=${project_name#mc-}          # hapus prefix mc- jika ada
target_dir="$HOME/storage/downloads/Termux/mc-$project_name"

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --target) shift; target_dir="$1" ;;
    --dry-run) dry_run=true ;;
    -h|--help)
      cat <<EOF
Usage: mc-export [options]

Options:
  --target <path>   Override export target dir
  --dry-run         Show actions but don't copy
  -h, --help        Show this help
EOF
      exit 0 ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
  shift
done

echo "🚀 Importing project: mc-$project_name"
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
  local step_speed=$(( (RANDOM % 3) + 1 ))  # biar tiap step beda sedikit
  local spin=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')

  bash -lc "$cmd" >"$tmp" 2>&1 & cmd_pid=$!

  while kill -0 "$cmd_pid" 2>/dev/null; do
    for s in "${spin[@]}"; do
      percent=$((percent + step_speed))
      [ $percent -gt 95 ] && percent=95  # jangan sampai 100 sebelum selesai
      printf "\r%s %s  " "$s" "$label"
      progress "$percent"
      sleep 0.12
      if ! kill -0 "$cmd_pid" 2>/dev/null; then break 2; fi
    done
  done
  wait "$cmd_pid"
  status=$?

  if [ $status -ne 0 ]; then
    printf "\r✖ %s gagal (exit %d)\n" "$label" "$status"
    tail -n 80 "$tmp"
    rm -f "$tmp"
    exit $status
  fi

  progress 100
  printf "  ✅ %s selesai\n" "$label"
  rm -f "$tmp"
}

# ---------------- determine steps ----------------
steps=0
steps=$((steps+1))  # +1 for sync
total_steps=$steps
current_step=0

# ---------------- 1) Sync (rsync) ----------------
current_step=$((current_step+1))
progress $((current_step-1)) $total_steps
echo
mkdir -p "$target_dir"
SYNC_CMD="rsync -a --delete --exclude 'node_modules' --exclude '.git' --exclude '.env' --exclude '*.log' \"$target_dir\"/ ./"
run_step "Syncing files to target" "$SYNC_CMD"
progress $current_step $total_steps

# final newline & toast
echo
termux-toast "Import mc-$project_name selesai" 2>/dev/null || true
echo "🎉 Import selesai: $target_dir"
