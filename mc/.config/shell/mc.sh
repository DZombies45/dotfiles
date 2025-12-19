
alias upnpm="ncu --reject '/^@minecraft\//' -u && npm install"

mc() {
  cd "$HOME/storage/shared/Android/data/com.mojang.minecraftpe/files/games/com.mojang/" || return
}

# load mc completion
if [ -f ~/.config/bash/completion/mc ]; then
  source ~/.config/bash/completion/mc
fi
