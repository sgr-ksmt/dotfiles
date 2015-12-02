#!usr/bin/zsh

source ~/.zplug/zplug

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"

zplug "k4rthik/git-cal", as:command, frozen:1

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/rbenv", from:oh-my-zsh

zplug "b4b4r07/enhancd", of:"*.sh"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose
