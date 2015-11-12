#...
DOTPATH=~/src/dotfiles
echo $DOTPATH
for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
exec zsh
