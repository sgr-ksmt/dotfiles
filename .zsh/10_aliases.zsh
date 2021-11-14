# aliases

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# enable alias after sudu
alias sudo='sudo '
alias be='bundle exec'
alias cof='clear; ls -lrt'
alias xcrmc='rm -rf ~/Library/Developer/Xcode/DerivedData/*'
alias df='df -h'
alias openrr='cd ~/Project/RubyRails/'
alias opengc='open -a "/Applications/Google Chrome.app"/'
alias emacs="emacs -nw"
alias mou='open -a "/Applications/Mou.app"'
alias xc='~/custom_shell/openxcw.sh'
alias zipcontentfiles='find . -maxdepth 1 -mindepth 1 -type d -exec zip -r {}.zip {} \;'
alias reboot_shell='exec $SHELL -l'

################################
## global alias

# less
alias -g L='| less'
# grep
alias -g G='| grep'

## for git
alias -g IS='`gh issue list | fzf | head -n 1 | cut -f1`'
alias ghi='(){gh issue view $1 -w}'
alias -g PR='`gh pr list | fzf | head -n 1 | cut -f1`'
alias ghp='(){gh pr view $1 -w}'
gh alias set reviews 'pr list --search "review:required"' > /dev/null 2>&1

# branches
alias -g B='`git branch | fzf --prompt "Branches>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g RB='`git branch -r | fzf --prompt "Remote Branches>" | head -n 1 | sed -e "s/^\*\s*//g" | sed "s/origin\///"`'
# remotes
alias -g R='`git remote | fzf --prompt "Remotes>" | head -n 1`'
# tags
alias -g T='`git tag | fzf --prompt "Tags>" | head -n 1`'

# toybox
alias -g TB='`toybox list | fzf --prompt "Playgrounds>" | sed -E "s/\(.*\)$//g"`'

# remote tags
function git-remote-tags(){
    local tags
    tags=$(git ls-remote --tags | awk '{ print $2 }')
    (echo "$tags") | sed -e '/^ *$/d' | fzf --prompt "Remote Tags>"
}
alias -g RT='$(git-remote-tags)'
# find hash
function git-hash(){
    git log --oneline --branches | fzf --prompt "Hashes>" | awk '{print $1}'
}
alias -g H='$(git-hash)'
# find changed files
function git-changed-files(){
    git status --short | fzf --prompt "Changed Files>" | awk '{print $2}'
}
alias -g F='$(git-changed-files)'

# get issue-number with ghi
function git-issue-number(){
    ghi list | sed -e '1,1d' | fzf --prompt "Issue Numbers>" | sed -e 's/^ *\([0-9][0-9]*\).*$/\1/g'
}
alias -g IN='$(git-issue-number)'

alias -g GH='`curl -sL https://api.github.com/users/$(git config --global user.name)/repos | jq -r ".[].full_name" | fzf +m --prompt "GITHUB REPOS>" | head -n 1`'

# swiftlint rules select with fzf
function swiftlint-rule-name(){
    swiftlint rules | grep -v -e '^\+\-*+' -e '^.*identifier' | awk '{ print $2 }' | fzf
}

alias -g SLR='$(swiftlint-rule-name)'

#####

git-checkout-from-issue() {
  local issues=$(hub issue 2> /dev/null | grep 'issues')
  if [ -z "$issues" ]; then
    echo "issue not found." 1>&2
    return
  fi
  local number=$(echo "$issues" | fzf --exit-0 +m --query "$LBUFFER" | sed 's/^[^0-9]*\([0-9]*\).*$/\1/1')
  if [ -z "$number" ]; then
    return
  fi
  echo "bugfix/issue_$number"
}
alias -g IB='$(git-checkout-from-issue)'

# git alias
alias g='git'

# fshow - git commit browser (enter for show, ctrl-d for diff)
fshow() {
    local out shas sha q k
    while out=$(
	    git tree --color=always |
		fzf --ansi --multi --no-sort --reverse --query="$q" \
		    --print-query --expect=ctrl-d); do
	    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}


alias gibogen='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | fzf | xargs gibo'

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