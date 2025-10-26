clear
echo ""

## import path
if [ -f ~/.bashrc_eval ]; then
    source ~/.bashrc_eval
    sleep .5
fi

## import path
if [ -f ~/.bashrc_path ]; then
    source ~/.bashrc_path
    sleep .5
fi

## import alias
if [ -f ~/.bashrc_alias ]; then
    source ~/.bashrc_alias
    sleep .5
fi

## import mc command
if [ -f ~/.bashrc_mc ]; then
    source ~/.bashrc_mc
    sleep .5
fi

## after all of it, do this
clear
echo -e "$(cat ~/.ascii-logo.txt)"
echo ""
