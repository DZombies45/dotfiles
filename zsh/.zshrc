# ~/.zshrc — custom config, no framework (bekas oh-my-zsh)
# Struktur tetap sama kayak sebelumnya: .zsh_core loop-source
# ~/.config/shell/*.sh (POSIX, shared bash+zsh) dan
# ~/.config/zsh/zshrc.d/*.zsh (zsh-only, urut berdasarkan nama file)

# custom completions dulu, baru fallback ke default
fpath=(
  $HOME/.config/zsh/completions
  $fpath
)

export EDITOR='nvim'

# ---- history (dulu ini default-nya oh-my-zsh, sekarang manual) ----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # history nyambung antar sesi/pane
setopt HIST_IGNORE_ALL_DUPS   # command duplikat gak numpuk
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE      # command yang diawali spasi gak disimpan
setopt EXTENDED_HISTORY       # simpan timestamp
setopt AUTO_CD                # ketik nama dir langsung cd

source ~/.zsh_core
