########################################
# set options
# http://voidy21.hatenablog.jp/entry/20090902/1251918174

setopt auto_param_slash
setopt list_types
setopt auto_menu
setopt interactive_comments
setopt prompt_subst
setopt transient_rprompt
setopt EXTENDED_HISTORY
# enable brach : ex -> mkdir {1 2 3}
setopt brace_ccl
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# Ctrl+Dでzshを終了しない
setopt ignore_eof
# '#' 以降をコメントとして扱う
setopt interactive_comments
# ディレクトリ名だけでcdする
setopt auto_cd
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 高機能なワイルドカード展開を使用する
setopt extended_glob