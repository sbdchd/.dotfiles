#!/usr/bin/env bash

# Determine current OS
if [[ $OSTYPE == darwin* ]]; then
    OS='mac'
elif [[ $OSTYPE == linux-gnu* ]]; then
    OS='linux'
else
    OS='unknown'
fi



# Aliases #
# alias ls according to the current os
if [[ $OS == "mac" ]]; then
    alias ls='ls -A -G -F'
elif [[ $OS == "linux" ]]; then
    alias ls='ls -A -F --color=auto'
fi
# ls with lots of data
alias ll='ls -l'

# Prompt user before taking action
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# General Commands
alias c="clear"
alias e='exit'
alias q='exit'

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

# Default places
alias projects='cd ~/Dropbox/$USER/projects'
alias desktop='cd ~/Desktop'
alias downloads='cd ~/Downloads'
alias dropbox='cd ~/Dropbox'
alias golang='cd $GOPATH/src/github.com/sbdchd'
alias apps='cd ~/Applications'
alias trash='cd ~/.Trash'
alias homebrew='cd /usr/local/Library/Formula'
alias caskroom='cd /usr/local/Library/Taps/caskroom'

if hash nvim 2>/dev/null; then
    alias ni='nvim'
fi

# Git Aliases
if hash git 2>/dev/null; then
    alias ga='git add'
    alias gb='git branch'
    alias gc='git commit'
    alias gca='git commit -a'
    alias gcl='git clone'
    alias gco='git checkout'
    alias gd='git diff'
    alias gl='git log'
    alias glist='git log --pretty=format: --name-status | cut -f2- | sort -u'
    alias glpretty='git log --graph --decorate --pretty=oneline --abbrev-commit'
    alias gls='git ls-files'
    alias gp='git push'
    alias gpl='git pull'
    alias gr='git remote'
    alias grb='git rebase'
    alias gre='git reset'
    alias grm='git rm'
    alias gs='git status'
    alias gst='git stash'
    alias gu='git undo'
fi
# Bash Completion - Git Aliases
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash

    __git_complete ga  _git_add
    __git_complete gb  _git_branch
    __git_complete gc  _git_commit
    __git_complete gco _git_checkout
    __git_complete gd  _git_diff
    __git_complete gl  _git_log
    __git_complete gp  _git_push
    __git_complete gpl _git_pull
    __git_complete gr  _git_remote
    __git_complete grb _git_rebase
    __git_complete gre _git_reset
    __git_complete grm _git_rm
    __git_complete gst _git_stash
    __git_complete gu  _git_undo
fi

if hash screenfetch 2>/dev/null; then
    alias screenfetch='screenfetch -d "+disk"'
fi

# docker machine aliases
if hash docker-machine 2>/dev/null; then
    alias dm='docker-machine'
    alias dmc='eval "$(docker-machine env default)"'
    alias dms='docker-machine start default'
    alias dme='docker-machine stop default'
fi

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
    #https://github.com/necolas/dotfiles
    alias flushdns="dscacheutil -flushcache"
    # Empty the Trash on all mounted volumes and the main HDD
    # Also, clear Apple’s System Logs to improve shell startup speed
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
fi

# Copy my public key to the pasteboard
if [[ $OS == mac ]]; then
    alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
fi



# Exports #
# make shells use history from other shells
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# disable the default virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# set default editor
if hash nvim 2>/dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
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

export PATH="/usr/local/sbin:$PATH"

# Go setup stuff
export GOPATH=$HOME/Dropbox/$USER/projects/go
export PATH=$PATH:$GOPATH/bin

# FZF
export FZF_DEFAULT_COMMAND='ag --hidden -U --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--color hl:221,hl+:221
--color pointer:143,info:143,prompt:109,spinner:143,pointer:143,marker:143'

# XDG
export XDG_CONFIG_HOME="$HOME"/.config

# Disable Homebrew Analytics
export HOMEBREW_NO_ANALYTICS=1
if [[ -e "$HOME/.homebrew_analytics_user_uuid" ]]; then
    rm -f "$HOME/.homebrew_analytics_user_uuid"
fi


# History #
# Number of lines of commands loaded & stored during a bash session
HISTSIZE=10000
# Number of lines of commands stored in .bash_history file persistently
HISTFILESIZE=10000
# ignore duplicated commands
HISTCONTROL=ignoreboth
# don't ignore commands that start with a space
HISTCONTROL=ignorespace



# Bash Prompt #
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

if hash virtualenv 2>/dev/null; then
    function venv() {
    local env="$1"
    if [ -f "$env/bin/activate" ]; then
        . "$env"/bin/activate
    fi
}
fi

# ANSI escape color codes
Color_Off='\e[0m'       # Text Reset
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
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
    PS1+="\[$Cyan\]\$DOCKER_MACHINE_NAME"   # display docker machine name
    PS1+="\n"
    PS1+="\[$Color_Off\]\$ "                # $ or # depending on user status
    export PS1
}
set_prompts
unset set_prompts



# Functions #
findtext() {
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
    mkdir -p "$@" && cd "$@" || exit
}

# http://serverfault.com/a/28649
# move up directories more easily
up() {
    cd "$(eval printf '../'%.s $(seq 1 $1))" || exit
}

# https://wiki.archlinux.org/index.php/Bash/Functions#cd_and_ls_in_one
# cd and ls combined
cl() {
    local dir="$1"
    local dir="${dir:=$HOME}"
    if [[ -d "$dir" ]]; then
        cd "$dir" >/dev/null || exit; ls
    else
        echo "bash: cl: $dir: Directory not found"
    fi
}

# https://github.com/paulirish/dotfiles/blob/master/.functions
# open most recent finder window directory in terminal
cdf() {
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || exit
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

#http://stackoverflow.com/a/13322667
localip() {
    while IFS=$': \t' read -ra line; do
        [ -z "${line%inet}" ] && \
            ip=${line[${#line[1]}>4?1:2]} && \
            [ "${ip#127.0.0.1}" ]
    done< <(LANG=C /sbin/ifconfig)
    echo "$ip"
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



# Tmux #
# https://wiki.archlinux.org/index.php/Tmux#Autostart_tmux_with_default_tmux_layout
if [[ -z "$TMUX" ]]; then
    ID="$(tmux ls | grep -vm1 attached | cut -d: -f1)" # get the id of a deattached session
    if [[ -z "$ID" ]]; then # if not available create a new one
        tmux new-session
    else
        tmux attach-session -t "$ID" # if available attach to it
    fi
fi



# Bash Settings #
# make * select normal and dot files
shopt -s dotglob

# more extensive pattern matching
shopt -s extglob

# fix minor errors when typing names of dirs
shopt -s cdspell

# append history instead of overwriting history file
shopt -s histappend

# Use vi/vim style commands to edit & select cli commands
# http://unix.stackexchange.com/a/43005
set -o vi



# Bash Completion #
if [ -f "$(brew --prefix)"/share/bash-completion/bash_completion ]; then
    . "$(brew --prefix)"/share/bash-completion/bash_completion
fi
# FZF completion
complete -F _fzf_file_completion -o default -o bashdefault ni
complete -F _fzf_file_completion -o default -o bashdefault bash



# for FZF previous command history search `<CTRL> R`
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
