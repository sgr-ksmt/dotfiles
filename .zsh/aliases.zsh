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


# global alias
alias -g L='| less'
alias -g G='| grep'
## for git (with peco)
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'

# git + peco
# find hash with peco
function git-hash(){
   git log --oneline --branches | peco --prompt "GIT HASH>" | awk '{print $1}'
 }

# find changed files
function git-changed-files(){
  git status --short | peco --prompt "GIT CHANGE FILES>" | awk '{print $2}'
}
alias -g F='$(git-changed-files)'
alias -g H='$(git-hash)'

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