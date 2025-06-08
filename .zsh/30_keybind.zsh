# emacs key bind
bindkey -e
bindkey -r '^G'
bindkey -r '^g'

## custom function & keybind

## cmd history serarch with peco

function select-history() {
  BUFFER=$(\history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# show list & browse Issue

function peco-github-issues () {
  local issues=$(hub issue 2> /dev/null | grep 'issues')
  if [ -z "$issues" ]; then
    echo -n 'No opened issues found.'
    zle accept-line
    return
  fi
  local issue=$(echo "$issues" | fzf --exit-0 +m --query "$LBUFFER" | sed -e 's/.*( \(.*\) )$/\1/')
  if [ -n "$issue" ]; then
    BUFFER="open ${issue}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N peco-github-issues
bindkey '^G^I' peco-github-issues

# # show ls & git status
# # http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
# function show_status() {
#   if [ -n "$BUFFER" ]; then
#     zle accept-line
#     return 0
#   fi
#   echo
#   ls_abbrev
#   show_git_status
#   zle accept-line
# }
# zle -N show_status
# bindkey '^[' show_status
select_worktree() {
  local worktrees
  worktrees=$(git worktree list --porcelain | awk '/worktree / {print $2}')
  if [[ -z "$worktrees" ]]; then
    zle clear-screen
    echo "No worktrees found."
    return 1
  fi

  local main_worktree=$(echo "$worktrees" | head -1)
  local repo_name=$(basename "$main_worktree")

  typeset -A path_map
  local display_list=""
  while IFS= read -r worktree_path; do
    local display_name
    if [[ "$worktree_path" == "$main_worktree" ]]; then
      display_name="${repo_name}:main"
    else
      local worktree_name=$(basename "$worktree_path")
      display_name="${repo_name}-worktrees/${worktree_name}"
    fi
    path_map[$display_name]=$worktree_path
    display_list+="${display_name}"$'\n'
  done <<< "$worktrees"

  local selected
  selected=$(printf "%s" "$display_list" | fzf)
  if [[ -n "$selected" ]]; then
    cd "${path_map[$selected]}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N select_worktree
bindkey '^[' select_worktree

function fzf-src () {
  local selected_dir=$(ghq list -p | fzf --query "$LBUFFER" --prompt="SRC DIRECTORY>")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

function show_git_status() {
  if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
    local repo_name=$(git rev-parse --show-toplevel | xargs basename )
    local header="--- git status ($repo_name) ---"
    local footer="${(r:${#header}::-:)}"
    echo
    echo -e "\e[0;33m$header\e[0m"
    git status -sb
    echo -e -n "\e[0;33m$footer\e[0m"
    zle accept-line
  fi
}
zle -N show_git_status
bindkey '^X^G' show_git_status

function checkout-pull-request () {
    local selected_pr_id=$(gh pr list | fzf | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N checkout-pull-request
bindkey "^g^p^p" checkout-pull-request

function view-pull-request () {
    local selected_pr_id=$(gh pr list | fzf | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr view ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N view-pull-request
bindkey "^g^p^v" view-pull-request