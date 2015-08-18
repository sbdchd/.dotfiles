#!/bin/sh

# Parts taken from https://github.com/necolas/dotfiles

link() {
    # Force create/replace the symlink.
    ln -fs "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}

# Copy `.gitconfig`.
# Any global git commands in `~/.bash_profile.local` will be written to
# `.gitconfig`. This prevents them being committed to the repository.
rsync -avz --quiet ${DOTFILES_DIRECTORY}/gitconfig  ${HOME}/.gitconfig

# Create the necessary symbolic links between the `.dotfiles` and `HOME`
# directory. The `bash_profile` sources other files directly from the
# `.dotfiles` repository.
link "bashrc"         ".bashrc"
link "bash_profile"   ".bash_profile"
link "curlrc"         ".curlrc"
link "inputrc"        ".inputrc"
link "gitattributes"  ".gitattributes"
link "gitignore"      ".gitignore"

echo "Dotfiles update complete!"
