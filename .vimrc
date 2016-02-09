scriptencoding utf-8

if has('vim_starting')
  filetype plugin off
  filetype indent off
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/vimproc.vim')
endif

set nocompatible
set backspace=start,eol,indent

set number
set clipboard=unnamed,autoselect
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set hlsearch


" 特殊記号の表示変更
set list
set listchars=tab:>\ ,eol:$

" SSH クライアントの設定によってはマウスが使える（putty だと最初からいける
set mouse=n
" これをしないと候補選択時に Scratch ウィンドウが開いてしまう
set completeopt=menuone

"" ショートカット
" 移動系
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap <C-Down> G
nnoremap <C-Up> gg
nnoremap <C-Right> $
nnoremap <C-Left> <S-0>
" 文字列検索のハイライト制御
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" Unite.vim bufferの起動
nnoremap <C-h> :Unite file_mru<CR>
inoremap <silent> jj <ESC>
"" Leader
let mapleader = "\<Space>"
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>

"" NeoBundle
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'git://github.com/kien/ctrlp.vim.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'https://github.com/cocopon/colorswatch.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tomasr/molokai'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bronson/vim-trailing-whitespace'
call neobundle#end()


"" colorscheme
let g:rehash256 = 1
colorscheme molokai
colorscheme custom
syntax on


"" NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
" <C-e>でNERDTreeをオンオフ いつでもどこでも
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>


"" Neocomplecache settings
let g:neocomplcache_enable_at_startup = 1


"" vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=4
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermfg=241 ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermfg=241 ctermbg=237


"" caw
map <C-c> <Plug>(caw:i:toggle)


"" lightline
set laststatus=2
set guifont=Ricty-RegularForPowerline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'inactive': {
      \   'right': [  ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ }
      \ }


"" handle cursorline
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

runtime macros/matchit.vim


filetype plugin on
filetype indent on
