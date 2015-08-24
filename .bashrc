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

alias ll='ls -l'

# Easier movement
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'  # https://github.com/necolas/dotfiles

# Alias vim to nvim if nvim is installed
if hash nvim 2>/dev/null; then
    alias vim='nvim'
    alias vi='nvim'
    alias ni='nvim'
fi

# Git Aliases
alias gs='git status'
alias gpl='git pull'
alias gp='git push'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gr='git rm'
alias gl='git log'
alias glpretty='git log --graph --decorate --pretty=oneline --abbrev-commit'

# General Commands
alias c="clear"

# IP addresses - https://github.com/necolas/dotfiles
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
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
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
## Make new shells get the history lines from all previous - https://github.com/necolas/dotfiles
# shells instead of the default "last window closed" history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# https://github.com/necolas/dotfiles/blob/master/shell/bash_prompt
prompt_git() {
    local s=""
    local branchName=""

    # check if the current directory is in a git repository
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?) == 0 ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then

            # ensure index is up to date
            git update-index --really-refresh  -q &>/dev/null

            # check for uncommitted changes in the index
            if ! $(git diff --quiet --ignore-submodules --cached); then
                s="$s+";
            fi

            # check for unstaged changes
            if ! $(git diff-files --quiet --ignore-submodules --); then
                s="$s!";
            fi

            # check for untracked files
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                s="$s?";
            fi

            # check for stashed files
            if $(git rev-parse --verify refs/stash &>/dev/null); then
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

set_prompts() {
    # set the terminal title to the current working directory
    PS1="\[\033]0;\w\007\]"

    PS1+="\n" # newline
    PS1+="\u" # username
    PS1+="@"
    PS1+="\h" # host
    PS1+=": "
    PS1+="\w" # working directory
    PS1+="\$(prompt_git \" on \")" # git repository details
    PS1+="\n"
    PS1+="\$ " # $ or # depending on user status

    export PS1
}

set_prompts
unset set_prompts

# Functions

# Make directory and enter it
md () { mkdir -p "$@" && cd "$@"; }

# http://serverfault.com/a/28649
# move up directories more easily
up() { cd $(eval printf '../'%.0s {1..$1}); }

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

# Go setup stuff
export GOPATH=$HOME/Dropbox/steve/projects/go

# https://wiki.archlinux.org/index.php/Tmux#Autostart_tmux_with_default_tmux_layout
# make Tmux open on terminal startup
if [[ -z "$TMUX" ]] ;then
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
