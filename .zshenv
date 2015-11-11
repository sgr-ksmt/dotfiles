#  zmodload zsh/zprof && zprof
# go path
export GOROOT=`go env GOROOT`
export GOPATH=~/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

source $HOME/.zalias

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
