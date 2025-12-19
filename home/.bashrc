# load shared shell config
#
for f in "$HOME/.config/shell/"*.sh; do
  [ -f "$f" ] && . "$f"
done

# load bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

eval "$(starship init bash)"
eval "$(zoxide init bash)"

# banner hanya di interactive shell utama
if [ -f "$HOME/.ascii-logo.txt" ]; then
	echo ""
	echo -e "$(cat ~/.ascii-logo.txt)"
fi

