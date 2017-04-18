#!/usr/bin/env zsh

# Determine current OS
if [[ $OSTYPE == darwin* ]]; then
    OS='mac'
elif [[ $OSTYPE == linux-gnu* ]]; then
    OS='linux'
else
    OS='unknown'
fi

if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

# enable vi mode
set -o vi
# disable esc time delay for vim mode
KEYTIMEOUT=1
# setup v to open current command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Setup z: https://github.com/rupa/z
source /usr/local/etc/profile.d/z.sh

# Setup fzf for ^r
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# improve tab completion
autoload -Uz compinit
compinit
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

source ~/.zplug/init.zsh

zplug 'lib/completion', from:oh-my-zsh

zplug 'zsh-users/zsh-completions'

zplug 'zsh-users/zsh-autosuggestions', at:develop
bindkey '^l' autosuggest-accept

zplug 'zsh-users/zsh-syntax-highlighting', defer:3

if ! zplug check --verbose; then
    printf 'Install zplug plugins? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# https://github.com/necolas/dotfiles/blob/master/shell/bash_prompt
prompt_git() {
    local s=""
    local branchName=""

    # check if the current directory is in a git repository
    if [[ "$(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?)" == 0 ]]; then
        # check if the current directory is in .git before running git checks
        if [[ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]]; then
            # ensure index is up to date
            git update-index --really-refresh  -q &>/dev/null

            # check for uncommitted changes in the index
            if ! git diff --quiet --ignore-submodules --cached; then
                s="$s+";
            fi

            # check for unstaged changes
            if ! git diff-files --quiet --ignore-submodules; then
                s="$s!";
            fi

            # check for untracked files
            if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
                s="$s?";
            fi

            # check for stashed files
            if git rev-parse --verify refs/stash &>/dev/null; then
                s="$s$";
            fi
            # https://gist.github.com/woods/31967
            # Set arrow icon based on status against remote.
            remote_pattern="# Your branch is (.*) of"
            if [[ $(git status 2> /dev/null) =~ ${remote_pattern} ]]; then
                if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
                    remote=">" # Ahead
                else
                    remote="<" # Behind
                fi
            else
                remote="" # Equal
            fi
            diverge_pattern="# Your branch and (.*) have diverged"
            if [[ $(git status 2> /dev/null) =~ ${diverge_pattern} ]]; then
                remote="<>" # Diverged
            fi
        fi

        # get the short symbolic ref
        # if HEAD isn't a symbolic ref, get the short SHA
        # otherwise, just give up
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
            git rev-parse --short HEAD 2> /dev/null || \
            printf "(unknown)")"

        [ -n "$s" ] && s=" [$s]"

        printf " %s" "$1$branchName$s$remote"
    fi
}

# disable the default virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    fi
    [[ -n "$venv" ]] && echo " $venv"
}

venv() {
    local env="$1"
    if [[ -f "$env/bin/activate" ]] && [[ -z "$VIRTUAL_ENV" ]]; then
        source "$env/bin/activate"
    else
        deactivate
    fi
}

autoload -U colors && colors

Color_Off=$'\e[0m'
Green=$'\e[0;32m'
Yellow=$'\e[0;33m'
Blue=$'\e[0;34m'
Purple=$'\e[0;35m'
Cyan=$'\e[0;36m'
Red=$'\e[0;31m'
White=$'\e[0;37m'

NEWLINE=$'\n'

PROMPT=$NEWLINE
PROMPT+="${Yellow}%n" # username
PROMPT+="%{$fg[white]%}@"
PROMPT+="%{$Purple%}%m" # host
PROMPT+=" %{$Blue%}%~" # working directory
PROMPT+='%{$Green%}$(prompt_git)'
PROMPT+='%{$Cyan%}$(virtualenv_info)'
PROMPT+="$DOCKER_MACHINE_NAME" # display docker machine name
# Date See: `man strftime` for more info
PROMPT+=" %{$White%}%D{%a %b %f %H:%M %p}" # date
PROMPT+=$NEWLINE
PROMPT+="%{$Color_Off%}❯ "

setopt promptsubst

# Aliases #
# alias ls according to the current os
if [[ $OS == "mac" ]]; then
    alias ls='ls -A -G -F'
elif [[ $OS == "linux" ]]; then
    alias ls='ls -A -F --color=auto'
fi

# Prompt user before taking action
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

alias c='clear'
alias q='exit'
alias o='open'

alias tmux-kill-extra='tmux kill-session -a'

alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gca='git commit -a'
alias gcl='git clone'
alias gco='git checkout'
alias gl='git log --graph --pretty=oneline --abbrev-commit --decorate'
alias glist='git log --pretty=format: --name-status | cut -f2- | sort -u'
alias glpretty="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gls='git ls-files'
alias gp='git push'
alias gpl='git pull'
alias gr='git remote'
alias grb='git rebase'
alias gre='git reset'
alias gs='git status -sb'
alias gst='git stash'

if [[ -n $TMUX ]]; then
    # needed to make fzf render somewhat correctly
    export TERM='screen-256color'
fi

if hash pmset 2>/dev/null; then
    alias sleep='pmset sleepnow'
fi

if hash osascript 2>/dev/null; then
    # slightly odd names to prevent collisions and accidental triggering
    alias shutdownc="osascript -e 'tell app \"System Events\" to shut down'"
    alias restartc="osascript -e 'tell app \"System Events\" to restart'"
fi

if hash ccat 2>/dev/null; then
    # better for cat abuse
    alias cat='ccat'
fi

alias wget='wget -c'

alias grep='grep --color=always'

alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# alias python http server if python is installed
if hash python3 2>/dev/null; then
    alias httpserver='python3 -m http.server'
elif hash python2 2>/dev/null; then
    alias httpserver='python2 -m SimpleHTTPServer'
fi

# IP addresses - https://github.com/necolas/dotfiles
if hash dig 2>/dev/null; then
    alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
fi

if [[ $OS == "mac" ]]; then
    # https://github.com/necolas/dotfiles
    alias flushdns="dscacheutil -flushcache"
    # Empty the Trash on all mounted volumes and the main HDD
    # Also, clear Apple’s System Logs to improve shell startup speed
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

    alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
fi

# Copy my public key to the pasteboard
if [[ $OS == mac ]]; then
    alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
fi


# set default editor
if hash nvim 2>/dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
alias e='$EDITOR'

# make postgresql cli tools work
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
# LS Colors
export CLICOLOR=1
if [[ $OS == "mac" ]]; then
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
fi
if [[ $OS == "linux" ]]; then
    # http://linux-sxs.org/housekeeping/lscolors.html
    LS_COLORS='di=34'   # directory
    LS_COLORS+=':fi=0'  # file
    LS_COLORS+=':ln=35' # symbolic link
    LS_COLORS+=':pi=5'  # fifo file
    LS_COLORS+=':so=5'  # socket file
    LS_COLORS+=':bd=5'  # block (buffered) special file
    LS_COLORS+=':cd=5'  # character (unbuffered) special file
    LS_COLORS+=':or=31' # symbolic link pointing to a non-existent file (orphan)
    LS_COLORS+=':mi=0'  # non-existent file pointed to by a symbolic link (visible when you type ls -l)
    LS_COLORS+=':ex=32' # executable permissions set
    export LS_COLORS
fi

export PATH="$PATH:/usr/local/sbin"
export PATH=$PATH:"$HOME"/bin

# Go setup stuff
export GOPATH=$HOME/Dropbox/$USER/projects/go

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# FZF
export FZF_DEFAULT_COMMAND='ag --hidden -U --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--color hl:221,hl+:221
--color pointer:143,info:143,prompt:109,spinner:143,pointer:143,marker:143'

# XDG
export XDG_CONFIG_HOME="$HOME"/.config

# Ignore Homebrew change
export HOMEBREW_CASK_OPTS='--caskroom=/opt/homebrew-cask/Caskroom'

# Disable Homebrew Analytics
export HOMEBREW_NO_ANALYTICS=1
if [[ -e "$HOME/.homebrew_analytics_user_uuid" ]]; then
    rm -f "$HOME/.homebrew_analytics_user_uuid"
fi

# Functions #
ft() {
    # 2nd optional argument for directory. Defaults to $PWD.
    if (( $# < 2 )); then
        local arg2=$PWD
    else
        local arg2="$2"
    fi
    if hash ag 2>/dev/null; then
        # -t search all text files
        # -Q match pattern litterally,
        # -f follow symlinks
        # --silent suppress log msgs & errors
        # --hidden search hidden files
        ag  -Q -f --silent --hidden "$1" "$arg2"
    else
        grep -riI --color "$1" "$arg2" 2>/dev/null
    fi
}

# Make directory and enter it
md() {
    mkdir -p "$@" && cd "$@"
}

# http://serverfault.com/a/28649
# move up directories more easily
up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

# https://wiki.archlinux.org/index.php/Bash/Functions#cd_and_ls_in_one
# cd and ls combined
cl() {
    local dir="$1"
    local dir="${dir:=$HOME}"
    if [[ -d "$dir" ]]; then
        cd "$dir" >/dev/null; ls
    else
        echo "bash: cl: $dir: Directory not found"
    fi
}

# https://github.com/paulirish/dotfiles/blob/master/.functions
# open most recent finder window directory in terminal
cdf() {
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

alias size='du -sh *'

if hash youtube-dl 2>/dev/null; then
    # https://github.com/exogen/dotfiles/
    play() {
        # Skip DASH manifest for speed purposes. This might actually disable
        # being able to specify things like 'bestaudio' as the requested format,
        # but try anyway.
        # Get the best audio that isn't WebM, because afplay doesn't support it.
        # Use "$*" so that quoting the requested song isn't necessary.
        youtube-dl --default-search=ytsearch: \
            --youtube-skip-dash-manifest \
            --output="${TMPDIR:-/tmp/}%(title)s-%(id)s.%(ext)s" \
            --restrict-filenames \
            --format="bestaudio[ext!=webm]" \
            --exec=afplay "$*"
    }

    mp3() {
        # Get the best audio, convert it to MP3, and save it to the current
        # directory.
        youtube-dl --default-search=ytsearch: \
            --restrict-filenames \
            --format=bestaudio \
            --extract-audio \
            --audio-format=mp3 \
            --audio-quality=1 "$*"
    }

    mp4() {
        youtube-dl --default-search=ytsearch: \
            --restrict-filenames \
            --format=best "$*"
    }
fi

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

# http://stackoverflow.com/a/13322667
localip() {
    while IFS=$': \t' read -ra line; do
        [ -z "${line%inet}" ] && \
            ip=${line[${#line[1]}>4?1:2]} && \
            [ "${ip#127.0.0.1}" ]
    done< <(LANG=C /sbin/ifconfig)
    echo "$ip"
}

# http://stackoverflow.com/a/19458217/3720597
if [[ $OS == "mac" ]]; then
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
fi

# disable npm's broken zsh completion
compdef return npm
