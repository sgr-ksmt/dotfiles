DOTPATH=$(cd $(dirname $0) && pwd)/..
echo 'dotfiles path :' $DOTPATH
echo
for f in .??*
do
  [ "$f" = ".git" ] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
exec zsh
