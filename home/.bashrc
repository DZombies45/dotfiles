eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
alias T="cd ~/storage/downloads/Termux/"
alias zipDc="~/compress.sh"
alias ls="lsd -aAF --group-dirs=first"
alias vim="nvim"
alias npr="npm run"
alias web="cd ~/dzombies45.github.io/ && bundle exec jekyll s"
alias lg="lazygit"
alias format='prettier --write "**/*.{js,ts,json}"'
alias mc="cd storage/shared/Android/data/com.mojang.minecraftpe/files/games/com.mojang/"
alias uang="node ~/manager_uang/uang.js"
alias lh="python -m http.server 8000 | am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8000' | termux-notification -t 'Web Server Aktif' -c 'Buka http://localhost:8000'"
alias backup_mc="bash ~/backup-mc.sh"
alias cpd="rsync -av --progress --exclude node_modules "
ranger_cd() {
    tempfile="$(mktemp -t ranger_cd.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$PWD}"
    test -f "$tempfile" && cd "$(cat "$tempfile")"
    rm -f "$tempfile"
}
alias r='ranger_cd'
alias cat='bat --paging=never --theme=tokyonight_night'
alias upnpm="ncu --reject '/^@minecraft\//' -u && npm install"
alias mc-export="mc-export.sh"
alias mc-import="mc-import.sh"
export PATH="$HOME:$PATH"
export NODE_PATH=$(npm root -g)
source ~/dotfiles/mc/.bash_completion
clear
echo -e "$(cat ~/.ascii-logo.txt)"
echo ""
