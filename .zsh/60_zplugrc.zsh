
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/emoji-cli"
zplug "k4rthik/git-cal", as:command, frozen:1

zplug "b4b4r07/enhancd", use:"*.sh"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
