#!/usr/bin/env zsh

# zmodload zsh/zprof

# enable vi mode
set -o vi
# disable esc time delay for vim mode
KEYTIMEOUT=1
# setup v to open current command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Setup z: https://github.com/rupa/z
source /opt/homebrew/etc/profile.d/z.sh

# improve tab completion
# make tab complete "hidden files"
_comp_options+=(globdots)
# make tab complete case insensitive
# http://superuser.com/a/1092328
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# make <shift>-<tab> work in completion menu
bindkey '^[[Z' reverse-menu-complete

setopt dotglob
setopt NO_NOMATCH

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

# append history when shell exits (use INC_APPEND_HISTORY to incrementally append)
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# make comments work in commandline
setopt interactivecomments

export SHELL='/usr/local/bin/zsh/'

# disable the default virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1


# Aliases #
alias ls='ls -A -G -F'

# Prompt user before taking action
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

alias c='clear'
alias q='exit'

alias ga='git add'
alias gap='git add --patch'
alias gb='git branch'
alias gc='git commit -v'
alias gd='git diff'
alias gca='git commit -a'
alias gcl='git clone'
alias gco='git checkout'
alias gl='git log --graph --pretty=oneline --abbrev-commit --decorate'
alias glist='git log --pretty=format: --name-status | cut -f2- | sort -u'
alias glpretty="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gls='git ls-files'
alias gp='git push'
alias gps='git push'
alias gpl='git pull'
alias gr='git remote'
alias grb='git rebase'
alias gre='git reset'
alias gs='git status -sb'
alias gst='git stash'
alias gstp='git stash pop'
alias gf='git commit -am "fix";git push'

fail() {
    echo "Error: $1" >&2
}

gnew() {
    git stash | grep -q 'No local changes to save'
    # 1 if local changes, 0 if no local changes
    local local_changes=$?
    git checkout main || fail "Could not checkout main"
    git pull || fail "Could not pull main"
    git checkout -b "$USER-$(uuidgen)" || fail "Could not create new branch"
    if [[ $local_changes -eq 1 ]]; then
        git stash apply --index || fail "Could not apply stash"
    fi
}

alias wget='wget -c'

alias grep='grep --color=always'

alias tmp='cd $(mktemp -d)'

# set default editor
export EDITOR=nvim

alias e="$EDITOR"
alias vim=e
alias f="fg"

# make postgresql cli tools work
# export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
# LS Colors
export CLICOLOR=1

# http://www.freebsd.org/cgi/man.cgi?query=ls&apropos=0&sektion=1&format=html
LSCOLORS='ex'   # dir
LSCOLORS+='fx'  # symbolic link
LSCOLORS+='bx'  # socket
LSCOLORS+='bx'  # pipe
LSCOLORS+='cx'  # executable
LSCOLORS+='bx'  # block special
LSCOLORS+='bx'  # character special
LSCOLORS+='ab'  # executable with setuid bit set
LSCOLORS+='ag'  # executable with setgid bit set
LSCOLORS+='ac'  # directory writable to others, with sticky bit
LSCOLORS+='ad'  # directory writable to others, without sticky bit
export LSCOLORS

export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
# make sure our zsh, not mac osx, is the first on the path
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:"$HOME"/bin
export PATH="$PATH:$HOME/Library/Python/3.7/bin"
export PATH="$PATH:$HOME/.local/bin"

export FLYCTL_INSTALL="/Users/steve/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# add more memory for typescript
export NODE_OPTIONS='--max_old_space_size=8192'

# setup xelatex
export PATH=$PATH:"/usr/local/texlive/2017/bin/x86_64-darwin/"

# needs ipdb to be installed but most projects have it
# export PYTHONBREAKPOINT=ipdb.set_trace

# Poetry
export PATH=$PATH:$HOME/.poetry/bin

# Pipx / pip
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/Library/Python/3.7/bin/"
export PATH="$PATH:$HOME/Library/Python/3.9/bin/"

# ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$PATH:$HOME/.gem/ruby/3.0.0/bin"

# ansible
export ANSIBLE_NOCOWS=1

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"

export PATH="/usr/local/opt/curl/bin:$PATH"

# FZF
export FZF_DEFAULT_COMMAND='rg --hidden --files --no-ignore-vcs -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--color hl:221,hl+:221
--color pointer:143,info:143,prompt:109,spinner:143,pointer:143,marker:143'

# XDG
export XDG_CONFIG_HOME="$HOME"/.config

# Disable Homebrew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

# Disable Homebrew Analytics
export HOMEBREW_NO_ANALYTICS=1
if [[ -e "$HOME/.homebrew_analytics_user_uuid" ]]; then
    rm -f "$HOME/.homebrew_analytics_user_uuid"
fi

# Disable Gatsby Analytics
export GATSBY_TELEMETRY_DISABLED=1

alias ports="lsof -PiTCP -sTCP:LISTEN"

gifify() {
  # from: https://gist.github.com/SlexAxton/4989674
  if [[ -n "$1" ]]; then
    ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
    time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
    rm -f out-static*.png
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

md() {
    mkdir -p "$@" && cd "$@"
}

up() {
  local d=""
  local limit=$1

  for _ in {1..$limit}; {
    d=$d/..
  }

  d=$(sed 's/^\///' <<< $d)

  if [ -z "$d" ]; then
    d=..
  fi

  cd $d
}

if hash bat 2>/dev/null; then
  alias cat='bat'
fi

# https://github.com/paulirish/dotfiles/blob/master/.functions
# open most recent finder window directory in terminal
cdf() {
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

mp3() {
    # Get the best audio, convert it to MP3, and save it to the current
    # directory.
    yt-dlp --default-search=ytsearch: \
        --restrict-filenames \
        --format=bestaudio \
        --extract-audio \
        --audio-format=mp3 \
        --audio-quality=1 "$*"
}

mp4() {
    yt-dlp -o "%(uploader)s:%(id)s:%(title).100B.%(ext)s" --format=mp4 "$*"
}

# https://wiki.archlinux.org/index.php/Man_page#Colored_man_pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[01;33;03;40m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

# http://stackoverflow.com/a/19458217/3720597
function clip() {
    if [[ -p /dev/stdin ]]; then
        # stdin is a pipe
        # stdin -> clipboard
        pbcopy
    else
        # stdin is not a pipe
        # clipboard -> stdout
        pbpaste
    fi
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# atuin an fzf alternative
eval "$(atuin init zsh)"

eval "$(starship init zsh)"

# zprof
