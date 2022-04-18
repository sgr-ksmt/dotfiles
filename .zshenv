#  zmodload zsh/zprof && zprof

###############################
# export

# language
export LANG=ja_JP.UTF-8

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/git/bin:$PATH"
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
export PATH=$PATH:/opt/brew/bin/yarn
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$PATH:$HOME/fvm/default/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:/opt/brew/bin"


# auto completions path
fpath=(/opt/brew/share/zsh-completions $fpath)
fpath=(/opt/brew/share/zsh/site-functions $fpath)

# don't duplicate path
typeset -U path cdpath fpath manpath

# compinit
autoload -U compinit
compinit -uC # C: uncheck insecure, fast

# enable colors
autoload -Uz colors
colors

# define LS_COLORS
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# fzf default options
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --multi"
export ENHANCD_FILTER=fzf:peco
##############################

# export ZPLUG_HOME=/usr/local/opt/zplug
# source $ZPLUG_HOME/init.zsh
source ~/.zplug/init.zsh

export ANDROID_HOME=$HOME/Library/Android/sdk

# go path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# History
# History file
export HISTFILE=~/.zsh_history
# History size in memory
export HISTSIZE=10000
# The number of histsize
export SAVEHIST=1000000
# The size of asking history
export LISTMAX=50

export REPORTTIME=5
export EMOJI_CLI_KEYBIND="^X^E"
