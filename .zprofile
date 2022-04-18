ARCH=$(uname -m)
if [[ $ARCH == arm64 ]]; then
    echo "Current Architecture: $ARCH"
	eval $(/opt/homebrew/bin/brew shellenv)
elif [[ $ARCH == x86_64 ]]; then
    echo "Current Architecture: $ARCH"
	eval $(/usr/local/bin/brew shellenv)
fi