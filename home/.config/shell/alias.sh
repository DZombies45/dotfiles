alias T="cd ~/storage/downloads/Termux/"
alias ls="lsd -aAF --group-dirs=first"
alias vim="nvim"
alias npr="npm run"
alias lg="lazygit"
alias format='prettier --write "**/*.{js,ts,json}"'
alias uang="node ~/manager_uang/uang.js"
alias pserver="python -m http.server 8000 | am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8000' | termux-notification -t 'Web Server Aktif' -c 'Buka http://localhost:8000'"

alias cpd="rsync -av --progress --exclude node_modules "

alias cat='bat --paging=never --theme=tokyonight_night'

