# 10-completion.zsh — compinit dengan cache, biar startup gak ngecek ulang
# security tiap kali (itu salah satu penyebab OMZ berasa lambat di Android)

ZCOMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "$(dirname "$ZCOMPDUMP")"

autoload -Uz compinit
# cek cache max 1x/hari (mtime), sisanya skip -C biar cepat
if [[ -n "$ZCOMPDUMP"(#qN.mh+24) ]]; then
  compinit -d "$ZCOMPDUMP"
else
  compinit -C -d "$ZCOMPDUMP"
fi

# replay compdef yang ditunda plugin turbo, WAJIB dipanggil setelah compinit
zinit cdreplay -q

# opsi completion umum
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# fzf-tab preview (kalau fzf ada)
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath 2>/dev/null'
