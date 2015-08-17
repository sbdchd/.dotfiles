" Vimrc sbdchd

" show the line number relative to the cursor line 
set relativenumber

" tells vim what type of background is used
set background=dark 

" highlight the screen line of the cursor
set cursorline 

" show the size of block one selected in visual mode
set showcmd

" turn on syntax highlighting
syntax on

" min number of screen lines above/below of cursor
set scrolloff=5 

" no annoying dings
set noerrorbells
set visualbell
" make visual bell do nothing
set t_vb= 
" ensure that the visual bell does nothing in gui mode
" also select correct font 
" TODO: check if this works correctly
if has("gui_running")
    autocmd GUIEnter * set vb t_vb=
    if has("gui_gtk2")
      set guifont=Inconsolata:h12
    elseif has("gui_macvim")
      set guifont=Menlo:h10
    elseif has("gui_win32")
     set guifont=Consolas:h11
    endif
endif

" make backspace work as expected
set backspace=indent,eol,start 

" ensure status line is always present
set laststatus=2 

" cursor breifly jumps to matching bracket upon the insertion
set showmatch 

" set time of match cursor switch
set matchtime=2

" necessary to make things work correctly
set nocompatible 

" show current mode below status line
set showmode

" clear status line
set statusline=

" full path to file
set statusline+=%F\ 

" modification flag
set statusline+=%m

" read-only flag
set statusline+=%r

" help flag
set statusline+=%h

" preview flag
set statusline+=%w%=

" current line, column
set statusline+=%v:%l\/

" number of lines
set statusline+=%L\ 

" file type if available otherwise encoding type
set statusline+=%{&fenc?&fenc:&enc}\ 

" file format dos || unix
set statusline+=%{&fileformat}\ 

" current syntax
set statusline+=%Y\ 

" % into the file
set statusline+=%p%%\ 

" needed for smartcase
set ignorecase 
" enable smart case sensitive search
set smartcase 

" ignore case when completing file names and directories
set wildignorecase

" mouse will only work with certain terminals
set mouse=a 
" number of spaces = <tab>
set tabstop=4 
" number of spaces for indent/autoindent
set shiftwidth=4 
" let backspace delete 4 space tab
set softtabstop=4

" convert tab to spaces
set expandtab 

" asks to save files before exiting with :q or :e
set confirm 

" allows buffer to stay loaded
set hidden 

set smartindent

" highlight search matches
set hlsearch

" shows matches as you type search command
set incsearch

" allow clipboard to transfer between system and vim
set clipboard=unnamed

" Add <Tab> completion for commands
set wildmenu
" list all matches and complete till the longest common string
set wildmode=list:longest

" use C as a command to clear search entry and their highlighting
command! C let @/=""

" increase history to 1000 items
set history=1000

" increase tab page max
set tabpagemax=50

" set default encoding
set encoding=utf-8

" make vim create unix endings by default but also be able to process dos
set filetype=unix,dos

" make cursor stays in general column when moving
set nostartofline

" increase redraw smoothness
set ttyfast

" quicker method for returning to normal mode
inoremap jj <ESC>

" detect markdown correctly
autocmd BufRead,BufNew *.md set filetype=markdown

" Disable Menu for Gvim
set go-=T

" add highlight guide at column number
set colorcolumn=81

" use an undo file
set undofile
" undo file directory
set undodir=~/.vim/undo
" number of undo levels
set undolevels=5000

" make vim use a different folder for swp files
set dir-=.
set dir+=/tmp

" ensure wrapping is enabled
set wrap
" show break with chars
set showbreak=..
" make wrapped lines indent visually Note: Requires special version of vim
silent! set breakindent

" move up visual line instead of file line
noremap j gj
noremap k gk

" add $ to end of word being changed/replaced
set cpoptions+=$

" set color scheme to molokai
silent! color molokai

" use certain characters to show whitespace characters
set listchars=tab:▸\
set listchars=nbsp:·
set listchars=eol:¬
" use list characters
set list

" read file again on change
set autoread

" vim-plug setup
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'fatih/vim-go'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
" Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-startify' 
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'

call plug#end()
