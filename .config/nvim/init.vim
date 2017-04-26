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

" Syntax
" limit syntax highlighting on long lines - can help avoid some slow downs
set synmaxcol=200
set showcmd
" no annoying dings
set noerrorbells
set visualbell
" make visual bell do nothing
set t_vb=

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
let &statusline .= '%{WindowNumber()}'
let &statusline .= ' '
let &statusline .= '%n' " buffer number
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
set tabstop=4
" number of spaces for indent/autoindent
set shiftwidth=4
" let backspace delete 4 space tab
set softtabstop=4
" convert tab to spaces
set expandtab
set smartindent
set nojoinspaces
" disable tabline
set showtabline=0

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

" Mappings
" set the leader key
let g:mapleader = ' '
" more efficient for typing commands
nnoremap ; :
vnoremap ; :
" helpful stuff
nnoremap H ^
nnoremap L $

if exists(':tnoremap')
    autocmd! TermOpen term://\.//* tnoremap <silent> <buffer><nowait> <esc><esc> <c-\><c-n>
endif

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

" allows for <Leader>w2 to switch to window 2
function! CreateWindowKeybinds()
    let i = 1
    while i <= 9
        execute 'nnoremap <silent> <Leader>w'.i.' :'.i.'wincmd w<CR>'
        execute 'nnoremap <silent> <Leader>'.i.' :'.i.'wincmd w<CR>'
        let i = i + 1
    endwhile
endfunction
call CreateWindowKeybinds()

" window splitting
nnoremap <leader>wv <C-W>v
nnoremap <leader>ws <C-W>s
nnoremap <leader>wt :terminal<CR>

" kill window
nnoremap <leader>wc <C-W>c
nnoremap <leader>wd <C-W>c buffer
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

" shell
command! Shell :split | exe "normal! <C-w>j" | terminal
nnoremap <leader>' :Shell<CR>

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
"http://stackoverflow.com/q/356126
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

if has('nvim')
    " remove new line characters in the terminal
    autocmd! TermOpen * if &buftype == 'terminal'
                \| setlocal nolist
                \| endif

    autocmd! BufEnter * if &buftype == 'terminal'
                \| startinsert
                \| endif

    " close term buffer on exit using a bit of a hack
    autocmd! TermClose * call feedkeys('<cr>')
endif

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
Plug 'junegunn/vader.vim'
Plug 'justinmk/vim-gtfo'
Plug 'milkypostman/vim-togglelist'
Plug 'qpkorr/vim-bufkill'
Plug 'sbdchd/neoformat'
Plug 'sbdchd/vim-run'
Plug 'sbdchd/vim-shebang'
Plug 'tpope/vim-eunuch'
Plug 'EinfachToll/DidYouMean'
Plug 'tpope/vim-unimpaired'
Plug 'shime/vim-livedown'

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': 'yes \| ./install'}
Plug 'junegunn/fzf.vim'
autocmd! VimEnter * command! -nargs=* Ag call fzf#vim#ag(
            \ <q-args>,
            \ "--hidden -U --ignore .git",
            \ fzf#vim#default_layout)
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

Plug 'majutsushi/tagbar'
nnoremap <leader>tt :TagbarToggle<CR>

Plug 'mbbill/undotree', {'on' : 'UndotreeToggle'}
nnoremap <leader>ut :UndotreeToggle<CR>

Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '❯❯'
let g:ale_sign_warning = '~❯'
highlight link ALEErrorSign WarningMsg
highlight link ALEWarningSign WarningMsg

let g:ale_linters = {
\   'rust': [],
\}

Plug 't9md/vim-textmanip'
map <C-j> <Plug>(textmanip-move-down)
map <C-k> <Plug>(textmanip-move-up)
map <C-h> <Plug>(textmanip-move-left)
map <C-l> <Plug>(textmanip-move-right)

" Git
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
Plug 'jreybert/vimagit'
Plug 'junegunn/gv.vim'
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'

" Interface
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
let g:startify_fortune_use_unicode = 1
Plug 'junegunn/goyo.vim'

" Syntax & Coloring
Plug 'ap/vim-css-color'
Plug 'xu-cheng/brew.vim'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'

" Motion
Plug 'buztard/vim-rel-jump'
Plug 'christoomey/vim-sort-motion'
Plug 'henrik/vim-indexed-search'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'wellle/targets.vim'
" make targets play nice with line text object by disabling `nl`
let g:targets_nlNL = 'n NL'

Plug 'easymotion/vim-easymotion'
" Move to char
map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader><Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Text Objects
Plug 'kana/vim-textobj-user'
            \| Plug 'glts/vim-textobj-comment'
            \| Plug 'kana/vim-textobj-entire'
            \| Plug 'kana/vim-textobj-function'
            \| Plug 'kana/vim-textobj-line'
            \| Plug 'michaeljsmith/vim-indent-object'

" Languages
Plug 'Glench/Vim-Jinja2-Syntax', {'for': ['html', 'jinja']}
Plug 'LnL7/vim-nix'
Plug 'Tyilo/applescript.vim'
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
Plug 'posva/vim-vue'
Plug 'rust-lang/rust.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-markdown'
Plug 'aliva/vim-fish'

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
" prevent vim-go from mapping :GoDoc to K
let g:go_doc_keywordprg_enabled      = 0

Plug 'pangloss/vim-javascript'
let g:javascript_enable_domhtmlcss = 1

" Autocompletion
Plug 'Shougo/deoplete.nvim', {'do': function('DoRemote')}
command! DeopleteEnable     call deoplete#enable()
command! DeopleteDisable    let b:deoplete_disable_auto_complete = 1
command! DeopleteDisableAll let g:deoplete#disable_auto_complete = 1
if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif
function! DeopleteToggle()
    if exists('b:deoplete_enabled') && b:deoplete_enabled == 1
        let b:deoplete_enabled = 0
        echom 'Deoplete: disabled'
        return deoplete#disable()
    endif
    let b:deoplete_enabled = 1
    echom 'Deoplete: enabled'
    return deoplete#enable()
endfunction
command! DeopleteToggle :call DeopleteToggle()
noremap <leader>ta :DeopleteToggle<CR>
" prevent deoplete from creating a buffer above
set completeopt-=preview
" Sources
Plug 'Shougo/neco-vim'
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-go', {'do': 'make'}
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
