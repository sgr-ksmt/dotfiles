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

nnoremap ; :
nnoremap : ;
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
