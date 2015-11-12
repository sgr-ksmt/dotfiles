#...
# DOTPATH=~/src/dotfiles
DOTPATH=$(cd $(dirname $0) && pwd) 
echo 'dotfiles path :' $DOTPATH
echo
for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
exec zsh
