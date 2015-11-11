# git Prompt Setting
source ~/.zsh/completions/git-prompt.sh

# color defines
local DEFAULT='%f'
local RED='%F{red}'
local GREEN='%F{green}'
local YELLOW='%F{yellow}'
local BLUE='%F{blue}'
local PURPLE='%F{purple}'
local LIGHT_BLUE='%F{cyan}'
local WHITE='%F{white}'

## Prompt
precmd () {
  PROMPT=$GREEN'[%n]'$DEFAULT' '$BLUE"$(pwd | sed -e "s,^$HOME,~," | perl -pe "s/~\/(.ghq|.go\/src|src)\/.+?\//ghq:/")"$DEFAULT' '$RED'$(__git_ps1 "(%s)")'$DEFAULT'
$ '
  RPROMPT=$GREEN'(%*)'$DEFAULT
}

# git ps1 settings
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_DESCRIBE_STYLE="default"
export GIT_PS1_SHOWCOLORHINTS=true
