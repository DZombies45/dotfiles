
alias upnpm="ncu --reject '/^@minecraft\//' -u && npm install"

mc() {
  cd "$HOME/storage/shared/Android/data/com.mojang.minecraftpe/files/games/com.mojang/" || return
}
