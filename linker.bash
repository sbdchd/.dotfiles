#!/usr/bin/env bash

# linker - system links dotfiles


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

    # http://stackoverflow.com/a/4774063
    DOTFILES_DIRECTORY="$(cd "$( dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

    # force create/replace the symlink.
    ln -fs "$DOTFILES_DIRECTORY/$arg1" "$HOME/$arg2"
}


# link files
link ".agignore"
link ".astylerc"
link ".editorconfig"
link ".eslintrc"
link ".ghci"
link ".gitconfig"
link ".gitignore"
link ".hushlogin"
link ".ideavimrc"
link ".inputrc"
link ".jsbeautifyrc"
link ".mdlrc"
link ".nanorc"
link ".pylintrc"
link ".remarkrc"
link ".spacemacs"
link ".stylelintrc"
link ".tigrc"
link ".tmux.conf"
link ".uncrustify.cfg"
link ".vimrc"
link ".vintrc.yaml"
link ".zshrc"

# link dirs
link -d ".vim"
link -d ".atom"


# neovim
mkdir -p       "$XDG_CONFIG_HOME/.config"
link  ".vim/"  "$XDG_CONFIG_HOME/nvim"
link ".config/nvim/init.vim" "$XDG_CONFIG_HOME/nvim/init.vim"


echo "dotfiles linked!"
