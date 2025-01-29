#######################################
# source
for f in ~/.zsh/[0-9]*.(sh|zsh)
do
  source "$f"
done
source ~/.zsh.local
# added by travis gem
# anyenv
eval "$(anyenv init - zsh)"
eval $(/opt/homebrew/bin/brew shellenv)
eval "$(mise activate zsh)"
# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
