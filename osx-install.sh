#!/bin/sh

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git
brew install vim
brew install wget
brew install curl
brew install htop-osx
brew install wakeonlan
brew install tmux
brew install reattach-to-user-namespace
brew install go

brew install python
brew install python3
brew install pypy
brew install pypy3
bash py-install.sh

brew install ruby
brew install rbenv
bash rb-install.sh

brew install node
bash js-install.sh

brew install sqlite
brew install postgresql
brew install mysql
brew install mongodb
brew install ssh-copy-id
brew install screenfetch

brew install ffmpeg
brew install youtube-dl

brew install sl
brew install cmatrix
brew install cowsay
brew install fortune

brew install brew-gem
brew-gem install lolcat

brew update
brew tap jlhonora/lsusb
brew install lsusb

brew tap neovim/neovim
brew install --HEAD neovim

# Install Homebrew-Cask
brew install caskroom/cask/brew-cask

brew cask install google-chrome
brew cask install firefox
brew cask install flux
brew cask install grandperspective
brew cask install virtualbox
brew cask install vagrant
brew cask install dockertoolbox
brew cask install postgres
brew cask install transmission
brew cask install 1password
brew cask install dropbox
brew cask install iterm2
brew cask install remote-desktop-connection # compatibility issues with later os versions - may need to edit formula manually
brew cask install atom
brew cask install intellij-idea-ce
brew cask install vlc
brew cask install keepingyouawake
brew cask install spectacle
brew cask install gmail-checker
brew cask install microsoft-office-365
brew cask install xquartz
brew cask install inkscape
brew cask install gimp
brew cask install audacity
brew cask install handbrake
brew cask install limechat
brew cask install the-unarchiver
brew cask install pgadmin3
brew cask install sqlitebrowser
brew cask install mobile-mouse-server

# Install Fonts
brew tap caskroom/fonts
brew cask install font-inconsolata
brew cask install font-fontawesome

# Install Vim Plug Package Manager
bash vimplug-install.sh

# Install TMUX Package Manager
bash tpm-install.sh

bash osx-defaults.sh
