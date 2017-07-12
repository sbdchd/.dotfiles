" show the line number relative to the cursor line
set relativenumber
" show actual line number instead of the relative 0
set number
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
" enable mouse for selecting
set mouse=a
" remember previous cursor position
function! RecallCursorPosition()
    " exlclude git commit messages
    if bufname('%') =~ '\.git\/COMMIT_EDITMSG'
        return
    endif
    if line("'\"") > 1 && line("'\"") <= line('$')
        exe "normal! g'\""
    endif
endfunction
autocmd! BufReadPost * call RecallCursorPosition()

" don't move the cursor back when exiting from insert mode
function! DesiredCol()
    let col = getpos('.')[2]
    if col == 1
        return col
    endif
    return col + 1
endfunction
autocmd! InsertLeave * call cursor(getpos('.')[1], DesiredCol())

set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:block

" limit syntax highlighting on long lines - can help avoid some slow downs
set synmaxcol=200
" disable startup message
set shortmess=I

" ~~~~~~~~~~Status Line~~~~~~~~~~
" show current mode below status line
set showmode

function! GitStatusLine()
    if !exists('b:git_dir')
        return ''
    endif
    " Note: idk why there is a 7 as an argument, I am just taking this from the fugitive repo
    return 'git:' . fugitive#head(7)
endfunction

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

set laststatus=2

" left side
let &statusline = '%#statuslinenc#' " color line with statuslinenc highlight group
let &statusline .= ' '
let &statusline .= '%f' " file name
let &statusline .= ' '
let &statusline .= '%{GitStatusLine()}'
let &statusline .= ' '
let &statusline .= '%m' " modification flag
let &statusline .= '%r' " read-only flag
let &statusline .= '%h' " help flag
let &statusline .= '%w' " preview flag

" right side
let &statusline .= '%='               " right align
let &statusline .= '%<'               " truncate here when necessary
let &statusline .= ' '
let &statusline .= '%{&filetype}'     " vim
let &statusline .= ' '
let &statusline .= '%{&fileencoding}' " utf-8
let &statusline .= ' '
let &statusline .= '%{&fileformat}'   " dos || unix
let &statusline .= ' '
let &statusline .= '%P'
let &statusline .= ' '

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Search
" needed for smartcase
set ignorecase
" enable smart case sensitive search
set smartcase
" ignore case when completing file names and directories
set wildignorecase

" clear search with <esc> + bodge to make :noh not stay at command line
nnoremap <esc> :noh<CR>:echo ""<CR>

" Tabs & Spaces
" number of spaces=<tab>
let indent_size = 2
let &tabstop = indent_size
" number of spaces for indent/autoindent
let &shiftwidth = indent_size
" let backspace delete indent_size space tab
let &softtabstop = indent_size
" convert tab to spaces
set expandtab
set smartindent
set nojoinspaces
" disable tabline
set showtabline=0

" Buffers
" asks to save files before exiting with :q or :e
set confirm
" prevent vim from asking if you want to save your changes on switching to a
" new buffer
set hidden
" jump to first open window that contains the specified buffer
set switchbuf=useopen

" Command Line
" list all matches and complete till the longest common string
set wildmode=list:longest

" Mappings
" set the leader key
let g:mapleader = ' '
" helpful stuff
nnoremap H ^
nnoremap L $

if exists('+inccommand')
    set inccommand=nosplit
endif

" copy entire file
command! Copy :%y+

" make y copy to clipboard automatically
set clipboard=unnamed

" use an undo file
set undofile
" undo file directory
set undodir=~/.vim/undo
" number of undo levels
set undolevels=5000
" make vim update more rapidly
set updatetime=750

" Wrapping & Folding
" ensure wrapping is enabled
set wrap
" show break with chars
set showbreak=↪
" make wrapped lines indent visually
if has('linebreak')
    set breakindent
endif
" disable folding
set nofoldenable

" ~~~~~~~~~~SPACESTEVEVIM~~~~~~~~~~

" better window nav
nnoremap <leader>wl <C-W>l
nnoremap <leader>wh <C-W>h
nnoremap <leader>wj <C-W>j
nnoremap <leader>wk <C-W>k
nnoremap <leader>w= <C-W>=
nnoremap <leader>ww :Windows<CR>

" window moving
nnoremap <leader>wL <C-W>L
nnoremap <leader>wH <C-W>H
nnoremap <leader>wJ <C-W>J
nnoremap <leader>wK <C-W>K

" window splitting
nnoremap <leader>wv <C-W>v
nnoremap <leader>ws <C-W>s

nnoremap <leader>bd :bdelete<CR>

" kill window
nnoremap <leader>wc <C-W>c
nnoremap <leader>wd <C-W>c
nnoremap <leader>wx <C-W>c

" exit vim
nnoremap <leader>qa :qa<CR>

command! Maximize :exe "normal! <C-w>\|<C-W>_"
command! Minimize :exe "normal! <C-W>="
function! ToggleMaximizeWindow()
    if !exists('b:window_maximized')
        let b:window_maximized = 0
    endif
    if b:window_maximized
        Minimize
        let b:window_maximized = 0
    else
        Maximize
        let b:window_maximized = 1
    endif
endfunction
nnoremap <leader>wm :call ToggleMaximizeWindow()<CR>

" spelling
syntax spell toplevel
nnoremap <leader>ts :set spell! spelllang=en<CR>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" disable netrw help banner
let g:netrw_banner = 0
nnoremap <leader>d :Explore<CR>

" List Chars
" use certain characters to show whitespace characters
set listchars=tab:▸\ ,nbsp:⎵,eol:¬,trail:·
" use list characters
set list

" change the default split seperator from | to a start bar like tmux
set fillchars=vert:│,diff:─

" Miscellaneous
" add $ to end of word being changed/replaced
set cpoptions+=$
" make vim create unix endings by default but also be able to process dos
" disabled the more option
set nomore
" make diffs default to vertical
set diffopt+=vertical
" swap files become more annoying than helpful
set noswapfile

" Commands
function! TrimWhiteSpace()
    let search = @/
    let view = winsaveview()
    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\s\+$//e
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
    let @/ = search
    call winrestview(view)
endfunction
command! TrimWhiteSpace :call TrimWhiteSpace()

function! TrimEndings()
    let search = @/
    let view = winsaveview()
    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    silent! %s/\r//g
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
    let @/ = search
    call winrestview(view)
endfunction
command! -bar TrimEndings :call TrimEndings()

function! ConvertEndings()
    let search = @/
    let view = winsaveview()
    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    silent! %s/\r/\r/g
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
    let @/ = search
    call winrestview(view)
endfunction
command! -bar ConvertEndings :call ConvertEndings()

command! -bar ReloadConfig :let s:m = @/
            \| let s:v = winsaveview()
            \| source $MYVIMRC
            \| filetype detect
            \| let @/ = s:m
            \| call winrestview(s:v)

" Automatically close vim if only the quickfix window is open
" http://stackoverflow.com/a/7477056/3720597
augroup QuickFixClose
    autocmd!
    autocmd WinEnter * if winnr('$') == 1 &&
                \getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"
                \| q
                \| endif
augroup END

augroup MakeQuickFixPrettier
    autocmd!
    autocmd BufRead * if &buftype == 'quickfix'
                \| setlocal colorcolumn=
                \| setlocal nolist
                \| endif
augroup END

" make vim reload file if it has changed on disk
autocmd! FocusLost,FocusGained,CursorMoved * if &buftype == ''
            \| checktime
            \| endif

" Plugins
" https://github.com/junegunn/vim-plug
function! DoRemote()
    UpdateRemotePlugins
endfunction
call plug#begin('~/.vim/plugged')

" Utilities
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-gtfo'
Plug 'sbdchd/neoformat'
Plug 'sbdchd/vim-shebang'
Plug 'tpope/vim-eunuch'
Plug 'EinfachToll/DidYouMean'
Plug 'shime/vim-livedown'
Plug 'Yggdroot/indentLine'
let g:indentLine_color_gui = '#3B4048'

Plug 'svermeulen/vim-easyclip'
nnoremap gm m

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': 'yes \| ./install'}
Plug 'junegunn/fzf.vim'
autocmd! VimEnter * command! -nargs=* Ag call fzf#vim#ag(
            \ <q-args>,
            \ "--hidden -U --ignore .git",
            \ {} )
nnoremap <silent> <leader>ls :Buffers<CR>
let g:fzf_buffers_jump = 1 " jump to preexisting window if possible
" search buffer
nnoremap <silent> <leader>s :BLines<CR>
" search help
nnoremap <silent> <leader>? :Helptags<CR>
" recent files
nnoremap <silent> <leader>r :History<CR>
" find files
nnoremap <leader>f :FZF<CR>

Plug 'junegunn/vim-peekaboo'
let g:peekaboo_delay   = 600
let g:peekaboo_compact = 1

Plug 'mbbill/undotree', {'on' : 'UndotreeToggle'}
nnoremap <leader>ut :UndotreeToggle<CR>

Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '❯❯'
let g:ale_sign_warning = '~❯'
highlight link ALEErrorSign WarningMsg
highlight link ALEWarningSign WarningMsg
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

Plug 't9md/vim-textmanip'
map <C-j> <Plug>(textmanip-move-down)
map <C-k> <Plug>(textmanip-move-up)

" Git
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'

Plug 'kshenoy/vim-signature'
" Syntax & Coloring

" Theme
Plug 'joshdick/onedark.vim'

" Motion
Plug 'buztard/vim-rel-jump'
Plug 'christoomey/vim-sort-motion'
Plug 'henrik/vim-indexed-search'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'wellle/targets.vim'
" make targets play nice with line text object by disabling `nl`
let g:targets_nlNL = 'n NL'

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Text Objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'michaeljsmith/vim-indent-object'

" Languages
Plug 'mxw/vim-jsx'
Plug 'Glench/Vim-Jinja2-Syntax', {'for': 'jinja'}
Plug 'LnL7/vim-nix'
Plug 'Tyilo/applescript.vim'
Plug 'aliva/vim-fish'
Plug 'ap/vim-css-color'
Plug 'cespare/vim-toml'
Plug 'dannywillems/vim-icalendar'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-lang/vim-elixir'
Plug 'hail2u/vim-css3-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'
Plug 'neovimhaskell/haskell-vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
" Plug 'posva/vim-vue'" " TODO: make not super slow
" files
Plug 'rust-lang/rust.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-markdown'

Plug 'fatih/vim-go', {'for': 'go'}
let g:go_highlight_functions         = 1
let g:go_highlight_methods           = 1
let g:go_highlight_structs           = 1
let g:go_highlight_structs           = 1
let g:go_highlight_operators         = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command                 = 'goimports'
let g:go_fmt_fail_silently           = 1
let g:go_fmt_autosave                = 0


" Autocompletion
Plug 'Shougo/deoplete.nvim', {'do': function('DoRemote')}
let g:deoplete#enable_at_startup = 1
" prevent deoplete from creating a buffer above
set completeopt-=preview
" Sources
Plug 'Shougo/neco-vim'
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-jedi'

call plug#end()

silent! colorscheme onedark
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
" see: https://github.com/neovim/neovim/issues/4696
if exists('&termguicolors') && has('nvim')
    set termguicolors
elseif exists('&guicolors')
    set guicolors
else
    set t_Co=256
endif
