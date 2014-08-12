" Har's vimrc
" 6/23/14
" 
" This has my preferred colorscheme and formatting options.  The jellybeans
" colorscheme will need to be added to new systems, and the guifont syntax
" will need to be modified (or the line deleted), but the rest of the config
" should be fine for all operating systems and stock vim install.  If folded,
" use zR to open all folds, zM to close all folds.
"
" General 
set nocompatible
filetype on
filetype plugin on
filetype indent on

" Pathogen
execute pathogen#infect()

set omnifunc=syntaxcomplete#Complete
set wildmenu
set wildmode=list:longest,full
syntax on
set number
set ruler
set ts=2
set sw=2
set numberwidth=6
set foldcolumn=3
set modeline
set modelines=5

" Special Options 
" t = auto-wrap text using textwidth
" c = auto-wrap, use comment leader 
" q = allow gq formatting of comments
" n = recognize lists when formatting
" j = when joining lines, remove comment leader
set fo=tcqnj

" GUI setup for gvim (minimal) 
set guioptions=
"Windows...
"set guifont=consolas:h10
"Ubuntu...
set guifont=Ubuntu\ Mono\ 10

" Colors
set t_Co=256
set bg=dark
colorscheme jellybeans
"colorscheme slate

" Doxygen Toolkit
let g:DoxygenToolkit_authorName="Harlan Shoop"
" Using defaults for everything else

"set for auto handling of folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" When I print to laser, I want B&W
set printoptions+=syntax:n

" Plugins to autorun
" Autorun NERDTree
autocmd vimenter * NERDTree

" Run NERDTree even if a file was not specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
