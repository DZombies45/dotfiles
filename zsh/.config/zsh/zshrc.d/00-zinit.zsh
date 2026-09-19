# 00-zinit.zsh — plugin manager pengganti oh-my-zsh
# zinit dipilih karena support turbo mode (lazy load) & ringan di Termux

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# --- pengganti plugin OMZ yang dulu dipakai: zsh-autosuggestions, F-Sy-H ---

# git alias
zinit ice wait lucid depth=1
zinit snippet OMZ::plugins/git/git.plugin.zsh

# autosuggestion (ghost text dari history)
zinit ice wait lucid atload'_zsh_autosuggest_start' depth=1
zinit light zsh-users/zsh-autosuggestions

# syntax highlighting (fork aktif dari F-Sy-H)
# zinit ice wait lucid depth=1
zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-history-substring-search
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit load 'zsh-users/zsh-history-substring-search'
zinit ice wait atload'_history_substring_search_config'

# completions tambahan (gh, npm, docker, dll makin lengkap)
zinit ice wait lucid blockf depth=1
zinit light zsh-users/zsh-completions

# fzf-tab: completion jadi interaktif kayak fzf (opsional, enak dipakai)
zinit ice wait lucid depth=1
zinit light Aloxaf/fzf-tab

# gh/github
zinit ice wait lucid
zinit snippet OMZP::gh

# vi-mode
zinit ice wait lucid
zinit snippet OMZP::vi-mode

# clipboard
zinit ice wait lucid
zinit snippet OMZL::clipboard.zsh

# gitignore
zinit ice wait lucid
zinit snippet OMZP::gitignore

# you should use
zinit ice wait lucid depth=1
zinit light MichaelAquilina/zsh-you-should-use

zinit ice wait lucid
zinit snippet OMZP::ssh

zinit ice wait lucid
zinit snippet OMZP::npm
