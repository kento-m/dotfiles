"-------------------------------------------------- 
"
" NeoBundle
"
"-------------------------------------------------- 
set nocompatible			" be iMproved
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle/'))
endif

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'aperezdc/vim-template'

NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
"NeoBundle 'vim-scripts/twilight'
"NeoBundle 'jonathanfilip/vim-lucius'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'vim-scripts/Wombat'
"NeoBundle 'tomasr/molokai'
"NeoBundle 'vim-scripts/rdark'

filetype plugin indent on	" required!
filetype indent on
syntax on

"-------------------------------------------------- 
"
" General
"
"-------------------------------------------------- 
set t_Co=256
"colorscheme railscasts
colorscheme hybrid

"vim と Mac のクリップボードを共有
"set clipboard+=unnamed

set showmatch
set backspace=2
set autoindent
set smarttab
set expandtab
set ts=4 sw=4 sts=4

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" w!! でスーパーユーザーとして保存
cmap w!! w !sudo tee > /dev/null %

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
au BufNewFile,BufRead * match ZenkakuSpace /　/

"-------------------------------------------------- 
"
" NERDTree
"
"-------------------------------------------------- 
nmap <silent> <C-e>	:NERDTreeToggle<CR>

"-------------------------------------------------- 
"
" Binary
"
"-------------------------------------------------- 
" vim -b : edit binary using xxd-format!
augroup Binary
	au!
	au BufReadPre  *.bin let &binary=1
	au BufReadPost * if &binary | %!xxd
	au BufReadPost * set ft=xxd | endif
	au BufWritePre * if &binary | %!xxd -r
	au BufWritePre * endif
	au BufWritePost * if &binary | %!xxd
	au BufWritePost * set nomod | endif
augroup END

"-------------------------------------------------- 
"
" syntastic
"
"-------------------------------------------------- 
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

"-------------------------------------------------- 
"
" vim-template
"
"-------------------------------------------------- 
let g:license = "MIT"
let g:email = "kento.m0505@gmail.com"
let g:username = "Kento Matsui"

