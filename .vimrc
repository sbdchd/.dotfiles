" Vim Config

" show the line number relative to the cursor line 
set relativenumber

" show actual line number instead of the relative 0
set number

" tells vim what type of background is used
set background=dark

" highlight the screen line of the cursor
set cursorline

" show the size of block one selected in visual mode
set showcmd

" turn on syntax highlighting
syntax on

" make vim update more rapidly
set updatetime=750

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
set noshowmode

" clear status line
set statusline=
" full path to file
" file name
set statusline+=%f\ 
" modification flag
set statusline+=%m 
" show git status if fugitive is installed but don't throw an error if it isn't
silent! set statusline+=%{fugitive#statusline()}
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
"set clipboard=unnamed
"set clipboard=unnamedplus

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

" more efficent for typing commands
nnoremap ; :
vnoremap ; :

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

" map esc to exit terminal mode [neovim]
silent! tnoremap <Esc> <C-\><C-n>

" add $ to end of word being changed/replaced
set cpoptions+=$

" Enable 256 color
set t_Co=256

" use certain characters to show whitespace characters
set listchars=tab:▸\ 
set listchars+=nbsp:⎵
set listchars+=eol:¬
set listchars+=trail:·
" use list characters
set list

" set the leader key
let mapleader = ' '

" read file again on change
set autoread

" vim-plug setup
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'Chiel92/vim-autoformat'
Plug 'Glench/Vim-Jinja2-Syntax', {'for': ['html', 'jinja']}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'benekastah/neomake'
Plug 'bling/vim-airline' | Plug 'sbdchd/airline-steve'
Plug 'chrisbra/Recover.vim'
Plug 'christoomey/vim-sort-motion'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'hail2u/vim-css3-syntax', {'for': ['html', 'css', 'javascript', 'jinja']}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree', {'on' : 'UndotreeToggle'}
Plug 'mhinz/vim-startify'
Plug 'milkypostman/vim-togglelist'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-troll-stopper'
Plug 'w0ng/vim-hybrid'
Plug 'wellle/targets.vim'

call plug#end()

" nerdcommenter
filetype plugin on

" fzf
set rtp+=~/.fzf

" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_y='%{&fenc?&fenc:&enc} %{&fileformat}'
let g:airline_section_z='%8.(%l/%L%)'
let g:airline_section_warning='%3.p%%'
let g:airline_theme='steve'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

" set color scheme
silent! color hybrid

" make diffs default to vertical
set diffopt+=vertical

" tagbar
noremap <leader>t :TagbarToggle<CR>

" undotree
noremap <leader>g :UndotreeToggle<CR>

" nerdtree
noremap <leader>d :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
" close vim if NERDTree is the last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"nerdtree git plugin
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "!",
            \ "Staged"    : "+",
            \ "Untracked" : "?",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }

" vim-javascript
let g:javascript_enable_domhtmlcss=1

" vim autoformat
let g:format = 1

let g:formatdef_goimports = '"goimports"'
let g:formatters_go = ['goimports']

let g:formatdef_rubocop = '"rubocop --auto-correct"'
let g:formatters_ruby = ['rubocop']
au filetype ruby set shiftwidth=2

function ToggleFormatter()
    if g:format == 1
        let g:format = 0
        echo "Disabled Formatter"
    else
        let g:format = 1
        echo "Enabled Formatter"
    endif
endfunction

function Formatter()
    if g:format == 1
        Autoformat
    endif
endfunction

noremap <leader>f :call ToggleFormatter()<CR>

au BufWrite * :call Formatter()

" neomake
autocmd! BufWritePost * Neomake

let g:neomake_error_sign = {
            \ 'text': '❯❯',
            \ 'texthl': 'ErrorMsg',
            \ }

let g:neomake_warning_sign = {
            \ 'text': '~❯',
            \ 'texthl': 'WarningMsg',
            \ }
let g:neomake_info = {
            \ 'text': '!>',
            \ 'texthl': 'WarningMsg',
            \ }

let g:neomake_go_gometalinter_maker = {
            \ 'args': ['-t', '%:p:h'],
            \ 'append_file': 0,
            \ 'errorformat':
            \ '%E%f:%l:%c:error: %m,' .
            \ '%E%f:%l::error: %m,' .
            \ '%W%f:%l:%c:warning: %m,' .
            \ '%W%f:%l::warning: %m'
            \ }
let g:neomake_go_enabled_makers = ['golint','go','gometalinter']


" added this so the extra '--shell=bash' argument gets included
let g:neomake_sh_shellcheck_maker = {
            \ 'args': ['-fgcc', '--shell=bash'],
            \ 'errorformat':
            \ '%f:%l:%c: %trror: %m,' .
            \ '%f:%l:%c: %tarning: %m,' .
            \ '%f:%l:%c: %tote: %m'
            \ }
let g:neomake_sh_enabled_makers = ['shellcheck']

" go vim
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0

"Automatically close vim if only the quickfix window is open
"http://stackoverflow.com/a/7477056/3720597
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

