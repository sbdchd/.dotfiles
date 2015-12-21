#!/bin/sh

# Determine current OS
if [[ $OSTYPE == darwin* ]]; then
    OS='mac'
elif [[ $OSTYPE == linux-gnu* ]]; then
    OS='linux'
else
    OS='unknown'
fi

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

alias ll='ls -l'

alias e='exit'

# Easier movement
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'  # https://github.com/necolas/dotfiles

# misspellings
alias mdkir='mkdir'

if hash pmset 2>/dev/null; then
    alias sleep='pmset sleepnow'
fi

if hash osascript 2>/dev/null; then
    # slightly odd names to prevent collisions and accidental triggering
    alias shutdownc="osascript -e 'tell app \"System Events\" to shut down'"
    alias restartc="osascript -e 'tell app \"System Events\" to restart'"
fi

if hash curl 2>/dev/null; then
    alias header='curl -I'
fi

if hash ccat 2>/dev/null; then
    # better for cat abuse
    alias cat='ccat'
fi

if hash wget 2>/dev/null; then
    alias wget='wget -c'
fi

if hash grep 2>/dev/null; then
    alias grep='grep --color=always'
fi

if [[ $OS == mac ]]; then
    alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
fi

# Go setup stuff
export GOPATH=$HOME/Dropbox/steve/projects/go
export PATH=$PATH:$GOPATH/bin

# Default places
alias projects='cd ~/Dropbox/steve/projects'
alias desktop='cd ~/Desktop'
alias downloads='cd ~/Downloads'
alias dropbox='cd ~/Dropbox'
alias golang='cd $GOPATH/src/github.com/sbdchd'
alias apps='cd ~/Applications'
alias trash='cd ~/.Trash'

# http://unix.stackexchange.com/a/43005
# Use vi/vim style commands to edit & select  cli commands
set -o vi

# Alias vim to nvim if nvim is installed
if hash nvim 2>/dev/null; then
    alias vim='nvim'
    alias vi='nvim'
    alias ni='nvim'
fi

# Git Aliases
if hash git 2>/dev/null; then
    alias g='git'
    alias gs='git status'
    alias gpl='git pull'
    alias gp='git push'
    alias gd='git diff'
    alias ga='git add'
    alias gc='git commit'
    alias grm='git rm'
    alias gl='git log'
    alias glpretty='git log --graph --decorate --pretty=oneline --abbrev-commit'
    alias gca='git commit -a'
    alias gaa='git add .'
    alias gco='git checkout'
    alias gcb='git checkout -b'
    alias gb='git branch'
    alias grb='git rebase'
fi

if hash python2 2>/dev/null; then
    alias py2='python2'
fi

if hash python3 2>/dev/null; then
    alias py3='python3'
fi

# check if python virtualenv is installed before adding alias
if hash virtualenv 2>/dev/null; then
    alias activate='. venv/bin/activate'
fi

# docker machine aliases
if hash docker-machine 2>/dev/null; then
    alias dm='docker-machine'
    alias dmc='eval "$(docker-machine env default)"'
    alias dms='docker-machine start default'
    alias dme='docker-machine stop default'
fi

if hash docker 2>/dev/null; then
    alias d='docker'
fi

# alias python http server if python is installed
if hash python3 2>/dev/null; then
    alias httpserver='python3 -m http.server'
elif hash python2 2>/dev/null; then
    alias httpserver='python2 -m SimpleHTTPServer'
fi

# General Commands
alias c="clear"

# IP addresses - https://github.com/necolas/dotfiles
if hash dig 2>/dev/null; then
    alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
fi

if [[ $OS == "mac" ]]; then
    alias localip="ipconfig getifaddr en1"

    #  Flush DNS cache - https://github.com/necolas/dotfiles
    alias flushdns="dscacheutil -flushcache"

    # Empty the Trash on all mounted volumes and the main HDD - https://github.com/necolas/dotfiles
    # Also, clear Apple’s System Logs to improve shell startup speed
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

    # Show/hide hidden files in Finder - https://github.com/necolas/dotfiles
    alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
fi

# Copy my public key to the pasteboard - https://github.com/necolas/dotfiles
if [[ $OS == mac ]]; then
    alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
fi

## Make new shells get the history lines from all previous - https://github.com/necolas/dotfiles
# shells instead of the default "last window closed" history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# set default editor
export EDITOR=vim

# Number of lines of commands loaded & stored during a bash session
HISTSIZE=1000
# Number of lines of commands stored in .bash_history file persistently
HISTFILESIZE=10000
HISTCONTROL=ignoreboth

# make postgresql cli tools work
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

# https://github.com/necolas/dotfiles/blob/master/shell/bash_prompt
prompt_git() {
    local s=""
    local branchName=""

    # check if the current directory is in a git repository
    if [ "$(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?)" == 0 ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then

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
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
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

        printf "%s" "$1$branchName$s$remote"
    else
        return
    fi
}

#http://stackoverflow.com/questions/10406926/how-to-change-default-virtualenvwrapper-prompt
virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    fi
    [[ -n "$venv" ]] && echo "$venv"
}

# disable the default virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

Color_Off='\e[0m'       # Text Reset

# Regular Colors
#Black='\e[0;30m'        # Black
#Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
#White='\e[0;37m'        # White

# Bold
#BBlack='\e[1;30m'       # Black
#BRed='\e[1;31m'         # Red
#BGreen='\e[1;32m'       # Green
#BYellow='\e[1;33m'      # Yellow
#BBlue='\e[1;34m'        # Blue
#BPurple='\e[1;35m'      # Purple
#BCyan='\e[1;36m'        # Cyan
#BWhite='\e[1;37m'       # White

# Underline
#UBlack='\e[4;30m'       # Black
#URed='\e[4;31m'         # Red
#UGreen='\e[4;32m'       # Green
#UYellow='\e[4;33m'      # Yellow
#UBlue='\e[4;34m'        # Blue
#UPurple='\e[4;35m'      # Purple
#UCyan='\e[4;36m'        # Cyan
#UWhite='\e[4;37m'       # White

# Background
#On_Black='\e[40m'       # Black
#On_Red='\e[41m'         # Red
#On_Green='\e[42m'       # Green
#On_Yellow='\e[43m'      # Yellow
#On_Blue='\e[44m'        # Blue
#On_Purple='\e[45m'      # Purple
#On_Cyan='\e[46m'        # Cyan
#On_White='\e[47m'       # White

# High Intensity
#IBlack='\e[0;90m'       # Black
#IRed='\e[0;91m'         # Red
#IGreen='\e[0;92m'       # Green
#IYellow='\e[0;93m'      # Yellow
#IBlue='\e[0;94m'        # Blue
#IPurple='\e[0;95m'      # Purple
#ICyan='\e[0;96m'        # Cyan
#IWhite='\e[0;97m'       # White

# Bold High Intensity
#BIBlack='\e[1;90m'      # Black
#BIRed='\e[1;91m'        # Red
#BIGreen='\e[1;92m'      # Green
#BIYellow='\e[1;93m'     # Yellow
#BIBlue='\e[1;94m'       # Blue
#BIPurple='\e[1;95m'     # Purple
#BICyan='\e[1;96m'       # Cyan
#BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
#On_IBlack='\e[0;100m'   # Black
#On_IRed='\e[0;101m'     # Red
#On_IGreen='\e[0;102m'   # Green
#On_IYellow='\e[0;103m'  # Yellow
#On_IBlue='\e[0;104m'    # Blue
#On_IPurple='\e[0;105m'  # Purple
#On_ICyan='\e[0;106m'    # Cyan
#On_IWhite='\e[0;107m'   # White

set_prompts() {
    # set the terminal title to the current working directory
    PS1="\[\033]0;\w\007\]"
    PS1+="\n"
    PS1+="\[$Yellow\]\u"                    # username
    PS1+="\[$Color_Off\]@"
    PS1+="\[$Purple\]\h"                    # host
    PS1+="\[$Blue\] \w"                     # working directory
    PS1+="\[$Green\]\$(prompt_git \" \")"   # git repository details
    PS1+=" \[$Cyan\]\$(virtualenv_info)"    # virtual environment status
    PS1+="\[$Cyan\]\${DOCKER_MACHINE_NAME}" # display docker machine name
    PS1+="\n"
    PS1+="\[$Color_Off\]\$ "                # $ or # depending on user status

    export PS1
}

set_prompts
unset set_prompts

# Functions

# search recessively
# 2nd optional argument for directory. Defaults to $PWD.
findtext() {
    if (( $# < 2 )); then
        local arg2=$PWD
    else
        local arg2="$2"
    fi
    grep -riI --color "$1" "$arg2" 2>/dev/null
}
# Make directory and enter it
md() {
    mkdir -p "$@" && cd "$@"
}

# http://serverfault.com/a/28649
# move up directories more easily
up() {
    cd "$(eval printf '../'%.s $(seq 1 $1))"
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

if hash awk 2>/dev/null && hash column 2>/dev/null; then
    size(){
        if (( $# > 0 )); then
            local item=$1
        else
            local item=$PWD
        fi
        ls -lnh "$item" | awk '{print $5, $9}' | column -t
    }
fi

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
        # Get the best audio, convert it to MP3, and save it to the current
        # directory.
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

#http://stackoverflow.com/a/19458217/3720597
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

if hash screenfetch 2>/dev/null; then
    alias screenfetch='screenfetch -d "+disk"'
fi

# tmux alias
if hash tmux 2>/dev/null; then
    alias ta="tmux attach"
fi

# https://wiki.archlinux.org/index.php/Tmux#Autostart_tmux_with_default_tmux_layout
# make Tmux open on terminal startup
if [[ -z "$TMUX" ]]; then
    ID="$(tmux ls | grep -vm1 attached | cut -d: -f1)" # get the id of a deattached session
    if [[ -z "$ID" ]]; then # if not available create a new one
        tmux new-session
    else
        tmux attach-session -t "$ID" # if available attach to it
    fi
fi


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

# make * select normal and dot files
shopt -s dotglob

export PATH="/usr/local/sbin:$PATH"

# for fzf previous command history search `<CTRL> R`
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
