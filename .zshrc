#######################################
# source
for f in ~/.zsh/[0-9]*.(sh|zsh)
do
  source "$f"
done
source ~/.zsh.local
# added by travis gem
[ -f /Users/Kishimoto/.travis/travis.sh ] && source /Users/Kishimoto/.travis/travis.sh
# anyenv
eval "$(anyenv init - zsh)"
eval $(/opt/homebrew/bin/brew shellenv)
. /usr/local/opt/asdf/asdf.sh
