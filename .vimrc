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

  " NerdTree
  call dein#add('scrooloose/nerdtree')

  " airline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " Coloer Scheme
  call dein#add('nanotech/jellybeans.vim')

  " git markdown
  call dein#add('plasticboy/vim-markdown')
  call dein#add('kannokanno/previm')
  call dein#add('tyru/open-browser.vim')

  " Org-mode
  call dein#add('jceb/vim-orgmode')
  call dein#add('tpope/vim-speeddating')

  " Node.js
  call dein#add('jelera/vim-javascript-syntax')
  call dein#add('pangloss/vim-javascript')
  call dein#add('myhere/vim-nodejs-complete')

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
" vim-airline
"
"-------------------------------------------------- 
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline_theme = 'tomorrow'
let g:airline_theme = 'deus'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = '⮀'            "左側に使用されるセパレータ
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'           "右側に使用されるセパレータ
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.crypt = '🔒'      "暗号化されたファイル
let g:airline_symbols.linenr = '¶'      "行
let g:airline_symbols.maxlinenr = '㏑'  "最大行
let g:airline_symbols.branch = '⭠'      "gitブランチ
let g:airline_symbols.paste = 'ρ'       "ペーストモード
let g:airline_symbols.spell = 'Ꞩ'       "スペルチェック
let g:airline_symbols.notexists = '∄'   "gitで管理されていない場合
let g:airline_symbols.whitespace = 'Ξ'  "空白の警告(余分な空白など)

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
" Markdown
"
"-------------------------------------------------- 
autocmd BufRead,BufNewFile *.mkd  set filetype=markdown
autocmd BufRead,BufNewFile *.md  set filetype=markdown
nnoremap <silent> <C-p> :PrevimOpen<CR>
let g:vim_markdown_folding_disabled=1
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '~/.vim/templates/previm/markdown.css'
