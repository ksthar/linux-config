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
syntax on
set number
set ruler
set ts=4
set sw=4
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
"Linux...
set guifont=Ubuntu\ Mono\ 10

" Colors
set t_Co=256
set bg=dark
colorscheme jellybeans
"colorscheme slate

" Doxygen Toolkit
let g:DoxygenToolkit_authorName="Harlan Shoop"
let g:DoxygenToolkit_blockHeader="****************************************************************** " 
let g:DoxygenToolkit_blockFooter="****************************************************************** "

" Using defaults for everything else

"set for auto handling of folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview
filetype plugin indent on

" When I print to laser, I want B&W
set printoptions+=syntax:n
