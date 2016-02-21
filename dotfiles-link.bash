#!/usr/bin/env bash

# Parts taken from https://github.com/necolas/dotfiles

#http://stackoverflow.com/a/4774063
DOTFILES_DIRECTORY="$(cd "$( dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

link() {
    # Force create/replace the symlink.
    ln -fs "$DOTFILES_DIRECTORY/$1" "$HOME/$2"
}

# Copy `.gitconfig`.
# Any global git commands in `~/.bash_profile.local` will be written to
# `.gitconfig`. This prevents them being committed to the repository.
cp -n .gitconfig  "$HOME"/.gitconfig

# Link .dotfiles to $HOME
link ".tmux.conf"    ".tmux.conf"
link ".vimrc"        ".vimrc"
link ".vimrc"        ".ideavimrc"
link ".vim/"         ".vim/"
link ".bashrc"       ".bashrc"
link ".bash_profile" ".bash_profile"
link ".inputrc"      ".inputrc"
link ".gitignore"    ".gitignore"
link ".eslintrc"     ".eslintrc"
link ".astylerc"     ".astylerc"
link ".nanorc"       ".nanorc"
link ".vintrc.yaml"  ".vintrc.yaml"

# neovim
XDG_CONFIG_HOME="$HOME"/.config
mkdir -p      "$XDG_CONFIG_HOME"
link ".vim/"  "$XDG_CONFIG_HOME/nvim"
link ".vimrc" "$XDG_CONFIG_HOME/nvim/init.vim"

echo "dotfiles link complete!"
