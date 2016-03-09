# based on :少し凝った zshrc
# http://mollifier.mit-license.org/

########################################


# don't duplicate path
typeset -U path cdpath fpath manpath


# auto completions path
fpath=($(brew --prefix)/share/zsh-completions $fpath)
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

# compinit
autoload -U compinit
compinit -uC # C: uncheck insecure, fast

# enable colors
autoload -Uz colors
colors


# color defines
local DEFAULT='%f'
local RED='%F{red}'
local GREEN='%F{green}'
local YELLOW='%F{yellow}'
local BLUE='%F{blue}'
local PURPLE='%F{purple}'
local LIGHT_BLUE='%F{cyan}'
local WHITE='%F{white}'

# emacs key bind
bindkey -e
bindkey -r '^G'
bindkey -r '^g'

# command history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# time
REPORTTIME=3

########################################
# set options
# http://voidy21.hatenablog.jp/entry/20090902/1251918174

setopt auto_param_slash

setopt list_types

setopt auto_menu

setopt interactive_comments

# prompt
setopt prompt_subst
setopt transient_rprompt

# enable brach : ex -> mkdir {1 2 3}
setopt brace_ccl

# 日本語ファイル名を表示可能にする


setopt print_eight_bit

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# completion style
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ignore parent ../
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# git Prompt Setting
source /usr/local/git/contrib/completion/git-prompt.sh

## Prompt
precmd () {
  PROMPT=$GREEN'[%n]'$DEFAULT' '$BLUE"$(pwd | sed -e "s,^$HOME,~," | perl -pe "s/~\/(.ghq|.go\/src|src)\/.+?\//ghq:/")"$DEFAULT' '$RED'$(__git_ps1 "(%s)")'$DEFAULT'
$ '
  RPROMPT=$GREEN'(%*)'$DEFAULT
}

# git ps1 settings
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="default"
GIT_PS1_SHOWCOLORHINTS=true

########################################

# pbcopy -> C
# $ hoge.txt C
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
  # Mac
  alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
  # Linux
  alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
  # Cygwin
  alias -g C='| putclip'
fi

########################################
# OS 別の設定
case ${OSTYPE} in
  darwin*)
  #Mac用の設定
  export CLICOLOR=1
  alias ls='ls -G -F'
  ;;
  linux*)
  #Linux用の設定
  alias ls='ls -F --color=auto'
  ;;
esac

#######################################

source $ZSHFILESPATH/zplugrc.zsh

ENHANCD_FILTER=fzf:peco
export ENHANCD_FILTER

function command_not_found_handler() {
  echo "(」・ω・)」うー！(／・ω・)／にゃー！→「$1」";
}

#######################################

## custom function & keybind

# hub -> git
# function git(){hub "$@"}
## cmd history serarch with peco

function peco-select-history() {
  BUFFER=$(\history -n -r 1 | fzf --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# limitation of ls
# http://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059

chpwd() {
  ls_abbrev
}

ls_abbrev() {
  if [[ ! -r $PWD ]]; then
    return
  fi
  # -a : Do not ignore entries starting with ..
  # -C : Force multi-column output.
  # -F : Append indicator (one of */=>@|) to entries.
  local cmd_ls='ls'
  local -a opt_ls
  opt_ls=('-aCF' '--color=always')
  case "${OSTYPE}" in
    freebsd*|darwin*)
    if type gls > /dev/null 2>&1; then
      cmd_ls='gls'
    else
      # -G : Enable colorized output.
      opt_ls=('-aCFG')
    fi
    ;;
  esac

  local ls_result
  ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

  local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

  local header="--- [$PWD] ---"
  local footer="${(r:${#header}::-:)}"
  echo -e "\e[0;33m$header\e[0m"
  if [ $ls_lines -gt 10 ]; then
    echo "$ls_result" | head -n 5
    echo '...'
    echo "$ls_result" | tail -n 5
    echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
  else
    echo "$ls_result"
  fi
  echo -e "\e[0;33m$footer\e[0m"
}

function show_git_status() {
  if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
    local repo_name=$(git rev-parse --show-toplevel | xargs basename )
    local header="--- git status ($repo_name) ---"
    local footer="${(r:${#header}::-:)}"
    echo
    echo -e "\e[0;33m$header\e[0m"
    git status -sb
    echo -e -n "\e[0;33m$footer\e[0m"
    zle accept-line
  fi
}
zle -N show_git_status
bindkey '^X^G' show_git_status

function peco-github-prs () {
  local prs=$(hub issue 2> /dev/null | grep 'pull')
  if [ -z "$prs" ]; then
    echo -n 'No opened PRs found.'
    zle accept-line
    return
  fi
  local pr=$(echo "$prs" | fzf --exit-0 +m --query "$LBUFFER" | sed -e 's/.*( \(.*\) )$/\1/')
  if [ -n "$pr" ]; then
    BUFFER="open ${pr}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N peco-github-prs
bindkey '^G^P' peco-github-prs

# show list & browse Issue

function peco-github-issues () {
  local issues=$(hub issue 2> /dev/null | grep 'issues')
  if [ -z "$issues" ]; then
    echo -n 'No opened issues found.'
    zle accept-line
    return
  fi
  local issue=$(echo "$issues" | fzf --exit-0 +m --query "$LBUFFER" | sed -e 's/.*( \(.*\) )$/\1/')
  if [ -n "$issue" ]; then
    BUFFER="open ${issue}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N peco-github-issues
bindkey '^G^I' peco-github-issues

# show ls & git status
# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function show_status() {
  if [ -n "$BUFFER" ]; then
    zle accept-line
    return 0
  fi
  echo
  ls_abbrev
  show_git_status
  zle accept-line
}
zle -N show_status
bindkey '^[' show_status



# ghq + peco
# cd to repository path
function fzf-src () {
  local selected_dir=$(ghq list -p | fzf --query "$LBUFFER" --prompt="SRC DIRECTORY>")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

# gitignore.io
# function _gigen() { curl -s https://www.gitignore.io/api/$1 ;}
# alias gigen='_gigen $(_gigen list | gsed "s/,/\n/g" | fzf --multi --prompt="Select ignore >" | gsed "N; s/\n/,/g") > .gitignore'
alias gibogen='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | fzf | xargs gibo'

function mkdircd () {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}


###########################################

# ## zsh compile
#  if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
#    zcompile ~/.zshrc
#  fi
# # zsh profile
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi

# added by travis gem
[ -f /Users/Kishimoto/.travis/travis.sh ] && source /Users/Kishimoto/.travis/travis.sh
