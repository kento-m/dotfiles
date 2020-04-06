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
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

let g:python3_host_prog = substitute(system("which python3"), '\n', '', 'g')

"-------------------------------------------------- 
"
" General
"
"-------------------------------------------------- 
set t_Co=256

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
