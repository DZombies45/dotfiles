alias T="cd ~/storage/downloads/Termux/"
alias ls="lsd -aAF --group-dirs=first"
alias vim="nvim"
alias npr="npm run"
alias lg="lazygit"
alias format='prettier --write "**/*.{js,ts,json}"'
alias pserver="python -m http.server 8000 | am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8000' | termux-notification -t 'Web Server Aktif' -c 'Buka http://localhost:8000'"
alias cpd="rsync -av --progress --exclude node_modules "
alias cat='bat --paging=never --theme=tokyonight_night'
alias pyserve="pkill -f server.py 2>/dev/null; python3 server.py > /dev/null 2>&1 & sleep 2 && am start -a android.intent.action.VIEW -d 'http://localhost:8000'"
alias pyservede="pkill -f server.py 2>/dev/null; python3 server.py & sleep 2 && am start -a android.intent.action.VIEW -d 'http://localhost:8000'"
alias pystop="pkill python"
alias serverd="cd ~/storage/downloads/server/ && pkill -f server.py 2>/dev/null; python3 server.py & sleep 3 && am start -a android.intent.action.VIEW -d 'http://localhost:8000' -n com.android.chrome/com.google.android.apps.chrome.Main"