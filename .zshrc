# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################

export LANG=ja_JP.UTF-8

# auto completions
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit
compinit -u -C

autoload -Uz colors
colors

# emacs key bind
bindkey -e

# command history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# time
REPORTTIME=3

########################################
# completion style
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
# zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
source /usr/local/git/contrib/completion/git-flow-completion.zsh
########################################

# git Prompt Setting
source /usr/local/git/contrib/completion/git-prompt.sh
function git(){hub "$@"}

## Prompt
setopt prompt_subst
setopt transient_rprompt
precmd () {
PROMPT='%F{green}[%n]%f %F{blue}%~%f %F{red}$(__git_ps1 "(%s)")%f
$ '
RPROMPT='%{${fg[green]}%}(%*)%{${reset_color}%}'
}

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="default"
GIT_PS1_SHOWCOLORHINTS=true
########################################
# オプション
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

## antigen
if [[ -f $HOME/antigen/antigen.zsh ]]; then
  source $HOME/antigen/antigen.zsh
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-completions src
  antigen bundle b4b4r07/enhancd
  antigen apply

  # enhancd
  ENHANCD_FILTER=peco; export ENHANCD_FILTER
fi

# vim:set ft=zsh:

## cool-peco
source $HOME/cool-peco/cool-peco
alias cpgc='cool-peco git-checkout'

#######################################

## custom function & keybind

## cmd history serarch with peco

function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
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

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

# show ls & git status
# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function show_status() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls_abbrev
    echo
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    echo
    fi
    echo
    zle reset-prompt
    return 0
}

zle -N show_status
bindkey '^]' show_status


###########################################

## zsh compile
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi
## zsh profile
if (which zprof > /dev/null) ;then
  zprof | less
fi
