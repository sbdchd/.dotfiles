#!/usr/bin/env zsh

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
[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

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

# make comments work in commandline
setopt interactivecomments

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

export SHELL='/usr/local/bin/zsh/'

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

# make sure pipenv instantiates a subshell in a normal manner such that the
# prompt will get reevaluated. Necessary for the nesting shell detecting code to work.
export PIPENV_SHELL_FANCY=1

virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    fi
    [[ -n "$venv" ]] && echo " $venv"
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

if [[ -n "$TMUX" || -n "$VIRTUAL_ENV" ]]; then
  LVL=$(($SHLVL-1))
else
  LVL=$SHLVL
fi

# print the ❯ for each nested zsh session
SUFFIX=$(printf '❯%.0s' {1..$LVL})

PROMPT=$NEWLINE
PROMPT+="${Yellow}%n" # username
PROMPT+="%{$fg[white]%}@"
PROMPT+="%{$Purple%}%m" # host
PROMPT+=" %{$Blue%}%~" # working directory
PROMPT+='%{$Green%}$(prompt_git)'
PROMPT+='%{$Cyan%}$(virtualenv_info)'
PROMPT+=" %{$Purple%}%(1j.β.)" # display β if background jobs exit
PROMPT+=$NEWLINE
PROMPT+="%{$Color_Off%}${SUFFIX} "

setopt promptsubst

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
alias gps='git push --set-upstream origin $(git symbolic-ref --short HEAD)'
alias gpl='git pull'
alias gr='git remote'
alias grb='git rebase'
alias gre='git reset'
alias gs='git status -sb'
alias gst='git stash'
alias gstp='git stash pop'

if [[ -n $TMUX ]]; then
    # needed to make fzf render somewhat correctly
    export TERM='screen-256color'
fi

alias cat='ccat'

alias wget='wget -c'

alias grep='grep --color=always'

alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

alias httpserver='python3 -m http.server'

ip() {
    curl -s https://freegeoip.net/json/ | jq -r '[.ip, .city, .region_code] | join(" ")'
}

localip() {
    ifconfig | grep "inet " | cut -f2 -d' ' | awk 'END {print}'
}

# https://github.com/necolas/dotfiles
alias flushdns="dscacheutil -flushcache"
# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Copy my public key to the pasteboard
alias pubkey="< ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"


# set default editor
export EDITOR=nvim

alias e="$EDITOR"
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
# make sure our zsh, not mac osx, is the first on the path
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:"$HOME"/bin

# Go setup stuff
export GOPATH=$HOME/Dropbox/$USER/projects/go

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# FZF
export FZF_DEFAULT_COMMAND='rg --hidden --files --no-ignore-vcs -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--color hl:221,hl+:221
--color pointer:143,info:143,prompt:109,spinner:143,pointer:143,marker:143'

# XDG
export XDG_CONFIG_HOME="$HOME"/.config

# Disable Homebrew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# Disable Homebrew Analytics
export HOMEBREW_NO_ANALYTICS=1
if [[ -e "$HOME/.homebrew_analytics_user_uuid" ]]; then
    rm -f "$HOME/.homebrew_analytics_user_uuid"
fi

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

# https://github.com/paulirish/dotfiles/blob/master/.functions
# open most recent finder window directory in terminal
cdf() {
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

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
        --format=mp4 "$*"
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

in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# git commit picker
fcs() {
  local commits commit
  if (in_git_repo) {
    commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --height 40% --tac +s +m -e --ansi --reverse) &&
    echo -n $(echo "$commit" | sed "s/ .*//")
  }
}

fcb() {
  if (in_git_repo) {
    git branch -a -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 40% --ansi --reverse --tac | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##'
  }
}

# Mesaure time for last command to complete
# see: https://github.com/wincent/wincent/blob/c1a9be84f781b360219fb57613ffdd95c683c1b4/roles/dotfiles/files/.zshrc#L242-L279
autoload -U add-zsh-hook

export RPROMPT=

typeset -F SECONDS
function record-start-time() {
  emulate -L zsh
  ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}
add-zsh-hook preexec record-start-time

function report-start-time() {
  if [ $ZSH_START_TIME ]; then
    local DELTA=$(($SECONDS - $ZSH_START_TIME))
    local DAYS=$((~~($DELTA / 86400)))
    local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
    local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
    local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
    local ELAPSED=''
    test "$DAYS" != '0' && ELAPSED="${DAYS}d"
    test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
    test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
    if [ "$ELAPSED" = '' ]; then
      SECS="$(print -f "%.2f" $SECS)s"
    elif [ "$DAYS" != '0' ]; then
      SECS=''
    else
      SECS="$((~~$SECS))s"
    fi
    ELAPSED="${ELAPSED}${SECS}"
    local ITALIC_ON=$'\e[3m'
    local ITALIC_OFF=$'\e[23m'
    export RPROMPT="%F{white}%{$ITALIC_ON%}${ELAPSED}%{$ITALIC_OFF%}%f"
    unset ZSH_START_TIME

  else
    # clear prompt on non-commands
    export RPROMPT=""
  fi
}
add-zsh-hook precmd report-start-time

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

# disable npm's broken zsh completion
compdef return npm
