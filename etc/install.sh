#...
CURRENT_DIR=$(cd $(dirname $0) && pwd)
export DOTPATH=~/.dotfiles
export GITHUB_URL="https://github.com/sgr-ksmt/dotfiles.git"

is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

has() {
  is_exists "$@"
}

e_error() {
  printf " \033[31m%s\033[m\n" "✖ $*" 1>&2
}

die() {
  e_error "$1" 1>&2
  exit "${2:-1}"
}

#####################################################
## Main

if [ -e $DOTPATH ]; then
  echo "$DOTPATH is already exist. clear it."
  rm -rf $DOTPATH
fi

if has "git"; then
  git clone --recursive "$GITHUB_URL" "$DOTPATH"
else
  die "git required"
fi

cd $DOTPATH
if [ $? -ne 0 ]; then
  die "not found: $DOTPATH"
fi

for f in .??*
do
  [ "$f" = ".git" ] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
cd $CURRENT_DIR
exec zsh
#####################################################
