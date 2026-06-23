# Shortcut
alias T="cd ~/storage/downloads/Termux/"
alias ls="lsd -aAF --group-dirs=first"
alias vim="nvim"
alias npr="npm run"
alias lg="lazygit"
alias cpd="rsync -av --progress --exclude node_modules "
alias cat='bat --paging=never --theme=tokyonight_night'
alias format='prettier --write "**/*.{js,ts,json}"'
alias rm="rm -I --preserve-root"
alias cp="cp -i"
alias mv="mv -i"
alias duit="node ~/.Duit/index.mjs"

# Python and Server stuff
alias pserver="python -m http.server 8000 | am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8000' | termux-notification -t 'Web Server Aktif' -c 'Buka http://localhost:8000'"
alias pyserve="pkill -f server.py 2>/dev/null; python3 server.py > /dev/null 2>&1 & sleep 2 && am start -a android.intent.action.VIEW -d 'http://localhost:8000'"
alias pyservede="pkill -f server.py 2>/dev/null; python3 server.py & sleep 2 && am start -a android.intent.action.VIEW -d 'http://localhost:8000'"
alias pystop="pkill python"
alias ping="ping -c 6"
alias hserve="am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8000' && hugo server --minify --noHTTPCache --port 8000"

# Package update
alias update="pkg update && pkg upgrade"
alias updatelist='pkg update && echo "---- upgradable pkg ----" && apt list --upgradable'
reload() {
    current_shell=$(basename "$SHELL")
    
    clear
    
    echo "🔄 Reloading $current_shell configuration..."
    
    case "$current_shell" in
        bash)
            # Reload bash config
            source ~/.bashrc
            ;;
        zsh)
            # Reload zsh config  
            source ~/.zshrc
            ;;
        *)
            echo "❌ Unknown shell: $current_shell"
            return 1
            ;;
    esac
    
    echo "✅ Reload complete! Aliases and functions updated."
}
alias rld='reload'