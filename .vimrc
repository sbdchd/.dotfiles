if !has('nvim')
    " set default encoding
    set encoding=utf-8
endif
" vint commands this
scriptencoding utf-8


if !has('nvim')
    " necessary to make things work correctly
    set nocompatible
    " increase redraw smoothness
    set ttyfast
    " add ability to use plugins for indent settings
    filetype plugin indent on
endif


" Cursor Line
" show the line number relative to the cursor line
set relativenumber
" show actual line number instead of the relative 0
set number
" highlight the screen line of the cursor
set cursorline
" min number of screen lines above/below of cursor
set scrolloff=5
" cursor briefly jumps to matching bracket upon the insertion
set showmatch
" set time of match cursor switch
set matchtime=2
" add highlight guide at column number
set colorcolumn=81
" make cursor stays in general column when moving
set nostartofline
" only highlight the cursorline in the active window
augroup CursorLine
    autocmd!
    autocmd VimEnter    * setl cursorline
    autocmd WinEnter    * setl cursorline
    autocmd BufWinEnter * setl cursorline
    autocmd WinLeave    * setl nocursorline
augroup END


" Syntax
" tells vim what type of background is used
set background=dark
" limit syntax highlighting on long lines - can help avoid some slow downs
set synmaxcol=200
if !has('nvim')
    " turn on syntax highlighting
    syntax on
endif
" Enable 256 color
set t_Co=256
set showcmd
" no annoying dings
set noerrorbells
set visualbell
" make visual bell do nothing
set t_vb=


" Status Line
if !has('nvim')
    " ensure status line is always present
    set laststatus=2
    " don't display '@' when line is cut off
    set display+=lastline
endif
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


" Search
" needed for smartcase
set ignorecase
" enable smart case sensitive search
set smartcase
" ignore case when completing file names and directories
set wildignorecase
" use C as a command to clear search entry and their highlighting
command! C let @/=""
if !has('nvim')
    " highlight search matches
    set hlsearch
    " shows matches as you type search command
    set incsearch
endif


" Tabs & Spaces
" number of spaces=<tab>
set tabstop=4
" number of spaces for indent/autoindent
set shiftwidth=4
" let backspace delete 4 space tab
set softtabstop=4
" convert tab to spaces
set expandtab
set smartindent
if !has('nvim')
    " make backspace work as expected
    set backspace=indent,eol,start
    set smarttab
    set formatoptions+=j
    " remove octals from incrementing and decrementing with <C-x> & <C-a>
    set nrformats-=octal
endif


" Buffers
" asks to save files before exiting with :q or :e
set confirm
" allows buffer to stay loaded
set hidden
" jump to first open window that contains the specified buffer
set switchbuf=useopen


" Command Line
" list all matches and complete till the longest common string
set wildmode=list:longest
if !has('nvim')
    " increase cmdline-history
    set history=10000
    " Add <Tab> completion for commands
    set wildmenu
endif


" Mappings
" set the leader key
let g:mapleader = ' '
" more efficient for typing commands
nnoremap ; :
vnoremap ; :
nnoremap K kJ
" make Y work like D
nnoremap Y y$
" paste from system register
nnoremap <leader>p "+p


" Undo and Swap
" use an undo file
set undofile
" undo file directory
set undodir=~/.vim/undo
" number of undo levels
set undolevels=5000
" make vim update more rapidly
set updatetime=750
" make vim use a different folder for swp files
set directory-=.
set directory+=~/tmp
" function to delete swap files
function! SwapRm()
    " hack to get output from :swapname
    silent! redir => l:path | silent swapname | redir end
    if exists('l:path')
        call delete(l:path)
        echom "swap deleted"
    endif
endfunction

command! SwapRm :call SwapRm()


" Wrapping & Folding
" ensure wrapping is enabled
set wrap
" show break with chars
set showbreak=..
" make wrapped lines indent visually
if has('linebreak')
    set breakindent
endif
" disable folding
set nofoldenable


" Movement
" move up visual line instead of file line
noremap j gj
noremap k gk
" better buffer nav
nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader>j :bnext<CR>
nnoremap <leader>k :bprevious<CR>
" map esc to exit terminal mode
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" disable netrw help banner
let g:netrw_banner = 0
nnoremap <leader>d :Explore<CR>
if !has('nvim')
    " mouse will only work with certain terminals
    set mouse=a
endif


" Spelling
syntax spell toplevel
nnoremap <leader>s :set spell! spelllang=en<CR>


" List Chars
" use certain characters to show whitespace characters
set listchars=tab:▸\ 
set listchars+=nbsp:⎵
set listchars+=eol:¬
set listchars+=trail:·
" use list characters
set list


" Miscellaneous
if !has('nvim')
    " read file again on change
    set autoread
endif
" add $ to end of word being changed/replaced
set cpoptions+=$
" make vim create unix endings by default but also be able to process dos
set filetype=unix,dos
" disabled the more option
set nomore
" make diffs default to vertical
set diffopt+=vertical


" Commands
"http://stackoverflow.com/q/356126
function! TrimWhiteSpace()
    let l:search = @/
    let l:view = winsaveview()
    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\s\+$//e
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
    let @/=l:search
    call winrestview(l:view)
endfunction
command! TrimWhiteSpace :call TrimWhiteSpace()

function! TrimEndings()
    let l:search = @/
    let l:view = winsaveview()
    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    silent! %s/\r//g
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
    let @/=l:search
    call winrestview(l:view)
endfunction
command! TrimEndings :call TrimEndings()

" Automatically close vim if only the quickfix window is open
" http://stackoverflow.com/a/7477056/3720597
augroup QuickFixClose
    autocmd!
    autocmd WinEnter * if winnr('$') == 1 &&
                \getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"
                \| q
                \| endif
augroup END

if has('nvim')
    " remove new line characters in the terminal
    autocmd! TermOpen * if &buftype == 'terminal'
                \| setlocal nolist
                \| endif
endif


" vim-plug plugins setup
" https://github.com/junegunn/vim-plug
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction
call plug#begin('~/.vim/plugged')

" Utilities
Plug 'benekastah/neomake'
Plug 'chrisbra/Recover.vim'
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar', {'on': 'TagBarToggle'}
Plug 'mbbill/undotree', {'on' : 'UndotreeToggle'}
Plug 'milkypostman/vim-togglelist'
Plug 'sbdchd/neoformat'
Plug 'sbdchd/vim-run'
Plug 'sbdchd/vim-shebang'
Plug 't9md/vim-textmanip'
Plug 'tpope/vim-eunuch'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'

" Interface
Plug 'vim-airline/vim-airline' | Plug 'sbdchd/airline-steve'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'


" Syntax & Coloring
Plug 'ap/vim-css-color'
Plug 'vim-utils/vim-troll-stopper'
Plug 'w0ng/vim-hybrid'


" Motion
Plug 'christoomey/vim-sort-motion'
Plug 'easymotion/vim-easymotion'
Plug 'henrik/vim-indexed-search'
Plug 'junegunn/vim-easy-align'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'


" Languages
Plug 'Glench/Vim-Jinja2-Syntax', {'for': ['html', 'jinja']}
Plug 'Tyilo/applescript.vim'
Plug 'dannywillems/vim-icalendar'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'hail2u/vim-css3-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'sentientmachine/erics_vim_syntax_and_color_highlighting', {'for': 'java'}
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-markdown'


" Autocompletion
Plug 'Shougo/deoplete.nvim', {'do': function('DoRemote')}
" Sources
Plug 'Shougo/neco-vim'
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-go', {'do': 'make'}
Plug 'zchee/deoplete-jedi'

if has('nvim')
    Plug 'awetzel/elixir.nvim', {'do': 'yes \| ./install.sh'}
endif

call plug#end()


" Plugin Config
" deoplete mappings
inoremap <C-j> <Down>
inoremap <C-k> <Up>
command! DeopleteEnable     call deoplete#enable()
command! DeopleteDisable    let b:deoplete_disable_auto_complete = 1
command! DeopleteDisableAll let g:deoplete#disable_auto_complete = 1
" prevent deoplete from creating a buffer above
set completeopt-=preview
noremap <leader>a :DeopleteEnable<CR>

" fzf
nnoremap <leader>f :FZF<CR>

" airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_y = '%{&fenc?&fenc:&enc} %{&fileformat}'
let g:airline_section_z = '%8.(%l/%L%)'
let g:airline_section_warning = '%3.p%%'
let g:airline_theme = 'steve'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

" set color scheme
silent! colorscheme hybrid

" signature
noremap <leader>m :SignatureToggle<CR>

" tagbar
noremap <leader>t :TagbarToggle<CR>

" undotree
noremap <leader>u :UndotreeToggle<CR>

" gitgutter
noremap <leader>g :GitGutterToggle<CR>

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-javascript
let g:javascript_enable_domhtmlcss = 1

" vim autoformat
let g:autoformat_autoindent = 1

" vim peekaboo
let g:peekaboo_delay = 600
let g:peekaboo_compact = 1

" neomake
augroup Neomake
    autocmd!
    autocmd BufWritePost * Neomake
    autocmd QuitPre * let g:neomake_verbose = 0
augroup END

let g:neomake_error_sign = {
            \ 'text': '❯❯',
            \ 'texthl': 'ErrorMsg',
            \ }

let g:neomake_warning_sign = {
            \ 'text': '~❯',
            \ 'texthl': 'WarningMsg',
            \ }
let g:neomake_info = {
            \ 'text': '!❯',
            \ 'texthl': 'WarningMsg',
            \ }

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0
" prevent vim-go from mapping :GoDoc to K
let g:go_doc_keywordprg_enabled = 0

" vim-textmanip
map <C-j> <Plug>(textmanip-move-down)
map <C-k> <Plug>(textmanip-move-up)
map <C-h> <Plug>(textmanip-move-left)
map <C-l> <Plug>(textmanip-move-right)
