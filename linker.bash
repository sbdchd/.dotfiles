#!/usr/bin/env bash

# linker - system links dotfiles

# http://stackoverflow.com/a/4774063
DOTFILES_DIRECTORY="$(cd "$( dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"


link() {
    arg1="$1"
    arg2="$2"

    # check length of args
    if [[ "$#" -lt 2 ]]; then
        arg2="$arg1"
    fi

    if [[ "$arg1" == "-d" ]]; then
        arg1="$arg2"
        arg2="$3"
    fi

    # force create/replace the symlink.
    ln -fs "$DOTFILES_DIRECTORY/$arg1" "$HOME/$arg2"
}


# link files
link ".astylerc"
link ".bash_profile"
link ".bashrc"
link ".editorconfig"
link ".eslintrc"
link ".gitconfig"
link ".gitignore"
link ".inputrc"
link ".jsbeautifyrc"
link ".mdlrc"
link ".nanorc"
link ".pylintrc"
link ".remarkrc"
link ".tmux.conf"
link ".uncrustify.cfg"
link ".vimrc"
link ".vimrc"        ".ideavimrc"
link ".vintrc.yaml"


# link dirs
link -d ".vim"
link -d ".atom"


# neovim
XDG_CONFIG_HOME="$HOME"/.config
mkdir -p      "$XDG_CONFIG_HOME"
link ".vim/"  "$XDG_CONFIG_HOME/nvim"
link ".vimrc" "$XDG_CONFIG_HOME/nvim/init.vim"


echo "dotfiles linked!"
