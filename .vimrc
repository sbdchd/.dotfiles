set encoding=utf-8

set autoindent

" read file again on change
set autoread

" enable mouse
set mouse=a

" make backspace work as expected
set backspace=indent,eol,start

set smarttab

set formatoptions+=j

" remove octals from incrementing and decrementing with <C-x> & <C-a>
set nrformats-=octal

" increase cmdline-history
set history=10000
" Add <Tab> completion for commands
set wildmenu


" highlight search matches
set hlsearch

" shows matches as you type search command
set incsearch

" ensure status line is always present
set laststatus=2

filetype plugin indent on

set ttyfast

syntax on

source $XDG_CONFIG_HOME/nvim/init.vim
