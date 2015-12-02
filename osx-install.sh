#!/bin/sh

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install curl
brew install git
brew install go
brew install htop-osx
brew install optipng
brew install reattach-to-user-namespace
brew install tmux
brew install tree
brew install vim
brew install wakeonlan
brew install wget

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

brew install cmatrix
brew install cowsay
brew install ffmpeg
brew install fortune
brew install mongodb
brew install mysql
brew install neovim/neovim/neovim
brew install nmap
brew install postgresql
brew install screenfetch
brew install sl
brew install sqlite
brew install ssh-copy-id
brew install youtube-dl

brew install brew-gem
brew-gem install lolcat

brew tap jlhonora/lsusb
brew install lsusb


# Install Homebrew-Cask
brew install caskroom/cask/brew-cask

brew cask install 1password
brew cask install adobe-illustrator-cc
brew cask install adobe-photoshop-cc
brew cask install arduino

brew cask install atom
bash atom-install.sh

brew cask install audacity
brew cask install dockertoolbox
brew cask install dropbox
brew cask install firefox
brew cask install flux
brew cask install gimp
brew cask install gmail-notifier
brew cask install google-chrome
brew cask install grandperspective
brew cask install handbrake
brew cask install intellij-idea-ce
brew cask install steam
brew cask install iterm2
brew cask install keepingyouawake
brew cask install limechat
brew cask install microsoft-office
brew cask install mobile-mouse-server
brew cask install pgadmin3
brew cask install postgres
brew cask install spectacle
brew cask install sqlitebrowser
brew cask install the-unarchiver
brew cask install transmission
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc
brew cask install wireshark

# Install Vim Plug Package Manager
bash vimplug-install.sh

# Install TMUX Package Manager
bash tpm-install.sh

bash osx-defaults.sh
