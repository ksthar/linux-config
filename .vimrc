" --------------------------------------------------------------------------------
" @file 	.vimrc
" @brief 	This has my preferred colorscheme and formatting options.  The
" 			jellybeans colorscheme will need to be added to new systems, and
" 			the guifont syntax will need to be modified (or the line deleted),
" 			but the rest of the config should be fine for all operating
" 			systems and stock vim install.  If folded,
"
" @author 	Harlan Shoop
" @version 	1
" @date 	2014-06-23
" --------------------------------------------------------------------------------
" use zR to open all folds, zM to close all folds.
"
" --------------------------------------------------------------------------------
" General 
" --------------------------------------------------------------------------------
set nocompatible			" Turn on extended functionality
filetype on					" Detect filetypes
filetype plugin on			" Activate any plugins for specific filetypes
filetype indent on			" Indent files as they are loaded

" --------------------------------------------------------------------------------
" Pathogen
" --------------------------------------------------------------------------------
execute pathogen#infect()	

" --------------------------------------------------------------------------------
" Syntax Autocompletion
" --------------------------------------------------------------------------------
set omnifunc=syntaxcomplete#Complete

" --------------------------------------------------------------------------------
" Command Autocompletion
" --------------------------------------------------------------------------------
set wildmenu
set wildmode=list:longest,full

" --------------------------------------------------------------------------------
" General Formatting Options
" --------------------------------------------------------------------------------
syntax on					" Turn on syntax highlighting
set number					" Turn on line numbers
set ruler					" Turn on ruler 
set ts=4					" Set tabstops to 4 spaces
set sw=4					" Set shift width to 4 spaces
set expandtab				" Use spaces instead of tabs
set numberwidth=6			" Allow six spaces for line numbers
set foldcolumn=3			" Use 3 spaces for fold column
set modeline				" Use modelines included in files
set modelines=5				" Read up to five modelines
set hlsearch				" Highlight searched words

" --------------------------------------------------------------------------------
" Special Options 
" --------------------------------------------------------------------------------
" t = auto-wrap text using textwidth
" c = auto-wrap, use comment leader 
" q = allow gq formatting of comments
" n = recognize lists when formatting
" j = when joining lines, remove comment leader
"
" NOTE: older versions of vim may not recognize all of these options.
"
set fo=tcqnj

" --------------------------------------------------------------------------------
" GUI setup for gvim (minimal) 
" --------------------------------------------------------------------------------
set guioptions=
"Windows...
"set guifont=consolas:h10
"Ubuntu...
set guifont=Ubuntu\ Mono\ 10
" --------------------------------------------------------------------------------

" --------------------------------------------------------------------------------
" Color Scheme
" --------------------------------------------------------------------------------
set t_Co=256				" Turn on 256 color compatibility
set bg=dark					" Setup for dark background
colorscheme jellybeans		" Select jellybeans as default colorscheme
"colorscheme slate			" Fallback colorscheme is slate

" --------------------------------------------------------------------------------
" Doxygen Toolkit
" --------------------------------------------------------------------------------
let g:DoxygenToolkit_authorName="Harlan Shoop"
let g:DoxygenToolkit_blockHeader="****************************************************************** " 
let g:DoxygenToolkit_blockFooter="****************************************************************** "

" --------------------------------------------------------------------------------
"  Printing
" --------------------------------------------------------------------------------
" When I print to laser, I want B&W
set printoptions+=syntax:n

" --------------------------------------------------------------------------------
"  Autorun Options
" --------------------------------------------------------------------------------
"set for auto handling of folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" Plugins to autorun
" Autorun NERDTree
"autocmd vimenter * NERDTree

" Run NERDTree even if a file was not specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" --------------------------------------------------------------------------------
"  									EOF
" --------------------------------------------------------------------------------
