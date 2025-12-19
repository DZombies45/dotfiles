# core.sh — POSIX, universal
# TIDAK BOLEH bash-only

# safety
set -o noclobber 2>/dev/null || true

# warna (portable)
green()  { printf '\033[32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[33m%s\033[0m\n' "$*"; }
red()    { printf '\033[31m%s\033[0m\n' "$*"; }

expand_path() {
  case "$1" in
    "~")   printf '%s\n' "$HOME" ;;
    "~/"*) printf '%s/%s\n' "$HOME" "${1#~/}" ;;
    *)     printf '%s\n' "$1" ;;
  esac
}
