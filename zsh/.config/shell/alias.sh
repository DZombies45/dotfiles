# use termux


# alias
alias T="cd ~/storage/downloads/Termux/"
alias ls="lsd -aAF --group-dirs=first"
alias ll="lsd -lAF --group-dirs=first --git"
alias la="lsd -laAF --group-dirs=first --git"
alias tree="lsd --tree"
alias rg='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias mkdir='mkdir -p'
alias copy='termux-clipboard-set'
alias fshare='copyparty -c .config/copyparty/copyparty.conf'

# shortcut
alias vim="nvim"
alias npr="npm run"
alias lg="lazygit"
alias -- -="cd .."

# function
alias format='prettier --write "**/*.{js,ts,json}"'
alias pserver="python -m http.server 8000 | am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8000' | termux-notification -t 'Web Server Aktif' -c 'Buka http://localhost:8000'"
alias cpd="rsync -av --progress --exclude node_modules "
alias cat='bat --paging=never --theme=tokyonight_night'
alias pyserve="pkill -f server.py 2>/dev/null; python3 server.py > /dev/null 2>&1 & sleep 2 && am start -a android.intent.action.VIEW -d 'http://localhost:8000'"
alias pyservede="pkill -f server.py 2>/dev/null; python3 server.py & sleep 2 && am start -a android.intent.action.VIEW -d 'http://localhost:8000'"
alias pystop="pkill python"
alias ping="ping -c 6"
alias update="pkg update && pkg upgrade"
alias rm="rm -I --preserve-root"
alias cp="cp -i"
alias mv="mv -i"
alias hserve="hugo server --minify --noHTTPCache --port 8000 && am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8000'"
