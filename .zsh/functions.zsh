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
  if [ ! $# -eq 1 ]; then
    echo "Library name required."
    exit 1
  fi
  LIBRARY_FILE="$1.podspec"
  cat <<'PODSPEC' > "$LIBRARY_FILE"
Pod::Spec.new do |s|
  s.name     = "___Name___"
  s.version  = "1.0.0"
  s.summary  = "___Summary___"
  s.homepage = "https://github.com/sgr-ksmt/#{s.name}"

  s.author = {
      "Suguru Kishimoto" => "melodydance.k.s@gmail.com"
  }

  s.ios.deployment_target = "8.0"
  s.source_files = "#{s.name}/**/*.swift"
  s.source = {
      :git => "#{s.homepage}.git",
      :tag => "#{s.version}",
  }

  s.license = {
    :type => "MIT",
    :text => <<-LICENSE
      Copyright (c) 2016 Suguru Kishimoto
      Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
      The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    LICENSE
  }

  # s.dependency ""
end
PODSPEC
  sed -i '' s/___Name___/"$1"/g $LIBRARY_FILE
}