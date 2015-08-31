#!/bin/sh

# Parts taken from https://github.com/necolas/dotfiles

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

link() {
    # Force create/replace the symlink.
    ln -fs "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}

# Copy `.gitconfig`.
# Any global git commands in `~/.bash_profile.local` will be written to
# `.gitconfig`. This prevents them being committed to the repository.
cp -n .gitconfig  ${HOME}/.gitconfig

# Create the necessary symbolic links between the `.dotfiles` and `HOME`
# directory. The `bash_profile` sources other files directly from the
# `.dotfiles` repository.

link ".tmux.conf"      ".tmux.conf"
link ".tmux/"          ".tmux"
link ".vimrc"          ".vimrc"
link ".vim/"           ".vim/"
link ".bashrc"         ".bashrc"
link ".bash_profile"   ".bash_profile"
link ".inputrc"        ".inputrc"
link ".gitignore"      ".gitignore"

echo "Dotfiles update complete!"
