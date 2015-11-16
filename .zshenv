#  zmodload zsh/zprof && zprof

###############################
# export

# language
export LANG=ja_JP.UTF-8

export PATH="/usr/local/bin:$PATH"

# go path
if [ -x "`which go`" ]; then
    export GOROOT=`go env GOROOT`
    export GOPATH="$HOME/go"
    export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
fi

# rbenv path
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

#eval "$(rbenv init - zsh)"

# define LS_COLORS
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# fzf default options
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --multi"
##############################
# source
ZSHFILESPATH=$HOME/.zsh
source $ZSHFILESPATH/aliases.zsh
