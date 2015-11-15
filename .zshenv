#  zmodload zsh/zprof && zprof

###############################
# export

# language
export LANG=ja_JP.UTF-8

# go path
if [ -x "`which go`" ]; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# rbenv path
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# define LS_COLORS
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# fzf default options
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi"
##############################
# source
ZSHFILESPATH=$HOME/.zsh
source $ZSHFILESPATH/aliases.zsh


#############################
# fast rbenv
if [ $+commands[rbenv] -ne 0 ]; then
  rbenv_init(){
    # eval "$(rbenv init - --no-rehash)" is crazy slow (it takes arround 100ms)
    # below style took ~2ms
    export RBENV_SHELL=zsh
#    source "$HOME/.rbenv/completions/rbenv.zsh"
    rbenv() {
      local command
      command="$1"
      if [ "$#" -gt 0 ]; then
        shift
      fi

      case "$command" in
      rehash|shell)
        eval "`rbenv "sh-$command" "$@"`";;
      *)
        command rbenv "$command" "$@";;
      esac
    }
    path=($HOME/.rbenv/shims $path)
  }
  rbenv_init
  unfunction rbenv_init
fi
