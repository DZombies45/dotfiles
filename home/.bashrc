echo ""

## import path
if [ -f ~/.bashrc_eval ]; then
    source ~/.bashrc_eval
fi

## import path
if [ -f ~/.bashrc_path ]; then
    source ~/.bashrc_path
fi

## import alias
if [ -f ~/.bashrc_alias ]; then
    source ~/.bashrc_alias
fi

## import mc command
if [ -f ~/.bashrc_mc ]; then
    source ~/.bashrc_mc
fi

## after all of it, do this
clear
echo -e "$(cat ~/.ascii-logo.txt)"
echo ""
