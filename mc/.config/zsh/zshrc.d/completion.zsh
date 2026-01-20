# pastikan custom completions dibaca sebelum oh-my-zsh
fpath=(
  $HOME/.config/zsh/completions
  $fpath
)
# Inisialisasi completion system

autoload -Uz compinit
# Skip security check untuk completion cache yang sudah ada
compinit -u



# if [ -f "$HOME/.config/zsh/completions/_mc-update" ]; then
#     autoload -Uz _mc-update
#     compdef _mc-update mc-update
# fi
# if [ -f "$HOME/.config/zsh/completions/_mc-test"]; then
#     autoload -Uz _mc-test
#     compdef _mc-test mc-test
# fi
# if [ -f "$HOME/.config/zsh/completions/_mc-export"]; then
#     autoload -Uz _mc-export
#     compdef _mc-export mc-export
# fi
# if [ -f "$HOME/.config/zsh/completions/_mc-import"]; then
#     autoload -Uz _mc-import
#     compdef _mc-import mc-import
# fi
#
# oh-my-zsh sudah memanggil compinit
