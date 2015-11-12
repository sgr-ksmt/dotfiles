#...
CURRENT_DIR=$(cd $(dirname $0) && pwd)
DOTPATH=~/.dotfiles; export DOTPATH
GITHUB_URL="https://github.com/sgr-ksmt/dotfiles.git"; export GITHUB_URL

is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

# has is wrapper function
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

if [ -e $DOTPATH ]; then
    echo "$DOTPATH is already exist. clear it."
    rm -rf $DOTPATH
fi

# git が使えるなら git
if has "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"
# 使えない場合は curl か wget を使用する
elif has "curl" || has "wget"; then
    tarball="https://github.com/b4b4r07/dotfiles/archive/master.tar.gz"
    
    # どっちかでダウンロードして，tar に流す
    if has "curl"; then
        curl -L "$tarball"

    elif has "wget"; then
        wget -O - "$tarball"

    fi | tar xv -
    
    # 解凍したら，DOTPATH に置く
    mv -f dotfiles-master "$DOTPATH"
else
    die "curl or wget required"
fi

cd $DOTPATH
if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

# 移動できたらリンクを実行する
for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
cd $CURRENT_DIR
exec zsh
