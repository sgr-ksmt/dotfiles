
git-remote-add-upstream() {
  if ! type jq > /dev/null 2>&1; then
    echo "'jq' is not installed." >&2
    exit 1
  fi
  if [ $# -ne 1 ]; then
    echo "Need repo name. e.g : 'user/repo'"
    exit 1
  fi
  local upstream=$(curl -L "https://api.github.com/repos/$1" | jq -r '.parent.full_name')
  if [ "$upstream" = "null" ]; then
    echo "upstream not found."
    exit 1
  fi
  git remote add upstream "git@github.com:${upstream}.git"
}
alias grau='git-remote-add-upstream'

## new-script template
## http://qiita.com/blackenedgold/items/c9e60e089974392878c8
new-script() {
    cat <<'SHELLSCRIPT' > "$1"
#!/bin/sh
usage() {
    cat <<HELP
NAME:
   $0 -- {one sentence description}

SYNOPSIS:
  $0 [-h|--help]
  $0 [--verbose]

DESCRIPTION:
   {description here}

  -h  --help      Print this help.
      --verbose   Enables verbose mode.

EXAMPLE:
  {examples if any}

HELP
}

main() {
    SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"

    for ARG; do
        case "$ARG" in
            --help) usage; exit 0;;
            --verbose) set -x;;
            --) break;;
            -*)
                OPTIND=1
                while getopts h OPT "$ARG"; do
                    case "$OPT" in
                        h) usage; exit 0;;
                    esac
                done
                ;;
        esac
    done

    # do something
}

main "$@"

SHELLSCRIPT
    chmod +x "$1"
}

new-podspec() {
  if [ $# -lt 1 ]; then
    echo "Library name required."
    exit 1
  fi
  : ${2:=1.0.0}
  cat << PODSPEC > "$1.podspec"
Pod::Spec.new do |s|
  s.name     = "$1"
  s.version  = "$2"
  s.summary  = "___Summary___"
  s.homepage = "https://github.com/sgr-ksmt/#{s.name}"
  s.author = {
      "Suguru Kishimoto" => "melodydance.k.s@gmail.com"
  }
  s.source = {
      :git => "#{s.homepage}.git",
      :tag => "#{s.version}",
  }

  s.ios.deployment_target = "8.0"
  s.source_files = "#{s.name}/**/*.swift"
  # s.dependency ""

  s.license = {
    :type => "MIT",
    :text => <<-LICENSE
      Copyright (c) 2016 Suguru Kishimoto
      Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
      The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
LICENSE
  }

end
PODSPEC
}