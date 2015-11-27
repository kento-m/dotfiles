"-------------------------------------------------- 
"
" NeoBundle
"
"-------------------------------------------------- 
set nocompatible			" be iMproved
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin(expand('~/.vim/bundle/'))
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
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'aperezdc/vim-template'

" Coloer Scheme
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'

" C lang
NeoBundle 'Rip-Rip/clang_complete', {
    \ 'autoload' : {'filetypes' : ['c', 'cpp']}
    \ }
NeoBundle 'osyo-manga/vim-marching', {
    \ 'depends' : ['Shougo/vimproc.vim', 'osyo-manga/vim-reunions'],
    \ 'autoload' : {'filetypes' : ['c', 'cpp']}
    \ }

" Node.js
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'myhere/vim-nodejs-complete'
call neobundle#end()

filetype plugin indent on	" required!
filetype indent on
syntax on

"-------------------------------------------------- 
"
" General
"
"-------------------------------------------------- 
set t_Co=256
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

set list
set listchars=eol:$,tab:>-,trail:-,extends:>,precedes:<

"-------------------------------------------------- 
"
" NERDTree
"
"-------------------------------------------------- 
nmap <silent> <C-e>	:NERDTreeToggle<CR>

"-------------------------------------------------- 
"
" Neocomplete
"
"-------------------------------------------------- 
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" For C lang
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" For perlomni
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" For Node.js
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
if !exists('g:neocomplchache_omni_functions')
    let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
let g:node_usejscomplete = 1

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
