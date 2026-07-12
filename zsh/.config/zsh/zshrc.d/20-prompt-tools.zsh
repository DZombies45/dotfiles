# 20-prompt-tools.zsh — pengganti plugin OMZ "starship" & "zoxide"
# (config starship.toml kamu gak berubah, cuma cara init-nya aja)

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v zoxide   >/dev/null 2>&1 && eval "$(zoxide init zsh)"
