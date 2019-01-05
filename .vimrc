"-------------------------------------------------- 
"
" Dein.vim
"
"-------------------------------------------------- 
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('scrooloose/nerdtree')

  " Coloer Scheme
  call dein#add('nanotech/jellybeans.vim')

  " Node.js
  call dein#add('jelera/vim-javascript-syntax')
  call dein#add('pangloss/vim-javascript')
  call dein#add('myhere/vim-nodejs-complete')

  " Org-mode
  call dein#add('jceb/vim-orgmode')
  call dein#add('tpope/vim-speeddating')
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

"-------------------------------------------------- 
"
" General
"
"-------------------------------------------------- 
set t_Co=256
colorscheme jellybeans

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

"set list
"set listchars=eol:$,tab:>-,trail:-,extends:>,precedes:<

"-------------------------------------------------- 
"
" NERDTree
"
"-------------------------------------------------- 
nmap <silent> <C-e>	:NERDTreeToggle<CR>
" work around of https://github.com/scrooloose/nerdtree/issues/928
let g:NERDTreeNodeDelimiter = "\u00a0"

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
