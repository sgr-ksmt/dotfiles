#######################################
# source
for f in ~/.zsh/[0-9]*.(sh|zsh)
do
  source "$f"
done
source ~/.zsh.local
# added by travis gem
eval $(/opt/homebrew/bin/brew shellenv)
eval "$(mise activate zsh)"

# pnpm
export PNPM_HOME="$HOME/.local/share/mise/installs/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
