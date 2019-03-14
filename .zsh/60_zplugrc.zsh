
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/emoji-cli"
zplug "k4rthik/git-cal", as:command, frozen:1

zplug "b4b4r07/enhancd", use:"*.sh"

zplug 'b4b4r07/zsh-history', as:command, use:misc/fzf-wrapper.zsh, rename-to:ff
if zplug check 'b4b4r07/zsh-history'; then
  export ZSH_HISTORY_FILE="$HOME/.zsh_history.db"
  ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
  ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
  ZSH_HISTORY_KEYBIND_SCREEN="^r^r"
  ZSH_HISTORY_KEYBIND_ARROW_UP="^p"
  ZSH_HISTORY_KEYBIND_ARROW_DOWN="^n"
fi

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
