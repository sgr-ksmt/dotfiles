#!usr/bin/zsh

# aliases

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# enable alias after sudu
alias sudo='sudo '

alias cof='clear; ls -lrt'
alias xcrmc='rm -rf ~/Library/Developer/Xcode/DerivedData/*'
alias df='df -h'
alias openrr='cd ~/Project/RubyRails/'
alias opengc='open -a "/Applications/Google Chrome.app"/'
alias emacs="emacs -nw"
alias mou='open -a "/Applications/Mou.app"'
alias openxcw='~/custom_shell/openxcw.sh'
alias zipcontentfiles='find . -maxdepth 1 -mindepth 1 -type d -exec zip -r {}.zip {} \;'
alias reboot_shell='exec $SHELL -l'

################################
## global alias

# less
alias -g L='| less'
# grep
alias -g G='| grep'

## for git

# branches
alias -g B='`git branch -a | fzf --prompt "Branches>" | head -n 1 | sed -e "s/^\*\s*//g"`'
# remotes
alias -g R='`git remote | fzf --prompt "Remotes>" | head -n 1`'
# tags
alias -g T='`git tag | fzf --prompt "Tags>" | head -n 1`'
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

#####

# git alias
alias github='hub'
alias g='git'
alias gf='git-flow'
alias gall='git addall'
alias gb='git branch'
alias gbd='git branch -d '
alias gc='git commit -v'
alias gcall='gall && gc'
alias gcm='git commit -m -v'
alias gl='git log'
alias gm='git merge --no-ff'
alias gp='git pull'
alias gce='gc --allow-empty'
alias gss='git status -s'
alias gf='git flow'
alias gff='gf feature'
alias gffs='gff start'
alias gfff='gff finish'
alias gffp='gff publish'
alias gfr='gf release'
alias gfrs='gf release start'
alias gfrf='gf release finish'

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
