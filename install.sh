#!/usr/bin/env sh

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# General Programs
brew install bash
brew install catimg
brew install emacs
brew install git
brew install gpg
brew install grep
brew install homebrew/dupes/openssh
brew install imagemagick
brew install make --with-default-names
brew install mercurial
brew install mosh
brew install neovim/neovim/neovim
brew install qpdf
brew install ranger
brew install rename
brew install ssh-copy-id
brew install sshuttle
brew install tig --with-docs
brew install tmux
brew install vim
brew install webarchiver
brew install zsh
brew install z
brew install diff-so-fancy

brew install youtube-dl
# ffmpeg is needed for some youtube-dl features
brew install ffmpeg
brew install lame
brew install hub

brew tap d12frosted/emacs-plus
brew install emacs-plus --with-cocoa --with-gnutls --with-librsvg --with-imagemagick --with-spacemacs-icon
brew linkapps

brew install sqlite

# Languages
brew install go
bash go-install.sh

brew install python
brew install python3
brew install pyenv
brew install pypy
brew install pypy3
bash py-install.sh

brew install ruby
brew install rbenv
bash rb-install.sh

brew install node
bash js-install.sh

brew install elixir

brew install ghc
brew install cabal-install

brew cask install java

# Utilities
brew install ag
brew install aspell
brew install astyle
brew install cloc
brew install ctags
brew install curl
brew install git-extras
brew install htop-osx
brew install httpie
brew install jlhonora/lsusb/lsusb
brew install jq
brew install sbdchd/macchanger/macchanger
brew install shellcheck
brew install trash
brew install tree
brew install uncrustify
brew install unp
brew install wakeonlan
brew install wget

# Other Utilities
brew install cmatrix
brew install cowsay
brew install fortune
brew install screenfetch

# Netsec
brew install aircrack-ng
brew install john-jumbo
brew install netcat6
brew install nmap

# Homebrew-Cask
brew cask install firefox
brew cask install firefoxnightly
brew cask install google-chrome

brew cask install 1password
brew cask install arduino
brew cask install audacity
brew cask install basictex
brew cask install clion
brew cask install dash
brew cask install discord
brew cask install docker
brew cask install dropbox
brew cask install flux
brew cask install gimp
brew cask install grandperspective
brew cask install handbrake
brew cask install hashcat
brew cask install imageoptim
brew cask install insomnia
brew cask install intellij-idea
brew cask install iterm2
brew cask install keepingyouawake
brew cask install limechat
brew cask install mactex
brew cask install malwarebytes-anti-malware
brew cask install microsoft-office
brew cask install mobile-mouse-server
brew cask install pgadmin3
brew cask install soulseek
brew cask install spectacle
brew cask install sqlitebrowser
brew cask install steam
brew cask install sublime-text
brew cask install the-unarchiver
brew cask install torbrowser
brew cask install transmission
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc
brew cask install wireshark

# git
brew cask install gitup

brew tap sbdchd/sleep-restart-shutdown
brew cask install sleep
brew cask install restart
brew cask install shutdown

brew tap sbdchd/neovim
brew cask install neovim-automator-app

brew tap caskroom/fonts
brew cask install font-latin-modern
brew cask install font-inconsolata
brew cask install font-source-code-pro
brew cask install font-lato
brew cask install font-fira-sans
brew cask install font-open-sans
brew cask install font-montserrat
brew cask install font-merriweather
brew cask install font-pacifico

# Install Vim Plug Package Manager
bash vimplug-install.sh

# Install TMUX Package Manager
bash tpm-install.sh

bash osx-defaults.sh

# setup italics for tmux
tic ./tmux-256color.terminfo
