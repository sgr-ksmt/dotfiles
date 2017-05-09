#  zmodload zsh/zprof && zprof

###############################
# export

# language
export LANG=ja_JP.UTF-8

export PATH="/usr/local/git/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

#eval "$(rbenv init - zsh)"

# define LS_COLORS
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# fzf default options
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --multi"
##############################
# source
ZSHFILESPATH=$HOME/.zsh
source $ZSHFILESPATH/aliases.zsh
source $ZSHFILESPATH/functions.zsh

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
