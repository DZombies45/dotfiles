eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
alias copyDc="rm -r ~/storage/downloads/Termux/Discord_bot2/ | rsync -av --exclude 'node_modules' ~/Discord_bot2/ ~/storage/downloads/Termux/Discord_bot2/"
alias T="cd ~/storage/downloads/Termux/test/"
alias FM="manager"
alias zipDc="~/compress.sh"
alias ls="lsd -a"
alias vim="nvim"
alias npr="npm run"
alias web="cd ~/dzombies45.github.io/ && bundle exec jekyll s"
alias lg="lazygit"
alias format='prettier --write "**/*.{js,ts,json}"'
alias mc="cd storage/shared/Android/data/com.mojang.minecraftpe/files/games/com.mojang/"
alias uang="node ~/manager_uang/uang.js"
alias lh="python -m http.server 8000 | am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8000' | termux-notification -t 'Web Server Aktif' -c 'Buka http://localhost:8000'"
alias backup_mc="bash ~/backup-mc.sh"
ranger_cd() {
    tempfile="$(mktemp -t ranger_cd.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$PWD}"
    test -f "$tempfile" && cd "$(cat "$tempfile")"
    rm -f "$tempfile"
}
alias r='ranger_cd'
source ~/dotfiles/mc/update
export PATH="$HOME:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
source ~/dotfiles/mc/.bash_completion
clear
echo -e "$(cat ~/.ascii-logo.txt)"
echo ""
