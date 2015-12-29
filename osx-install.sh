#!/bin/sh

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# General Programs
brew install bash
brew install git
brew install neovim/neovim/neovim
brew install optipng
brew install reattach-to-user-namespace
brew install ssh-copy-id
brew install tmux
brew install vim

brew install youtube-dl
# ffmpeg is needed for some youtube-dl features
brew install ffmpeg

# DBs
brew install mongodb
brew install mysql
brew install postgresql
brew install sqlite

# Languages
brew install go
bash go-install.sh

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

# Utilities
brew install ag
brew install ccat
brew install curl
brew install highlight
brew install htop-osx
brew install jlhonora/lsusb/lsusb
brew install sbdchd/macchanger/macchanger
brew install shellcheck
brew install tree
brew install unp
brew install wakeonlan
brew install wget

# Other Utilities
brew install brew-gem
brew install cmatrix
brew install cowsay
brew install fortune
brew install screenfetch
brew install sl
brew-gem install lolcat

# Netsec
brew install aircrack-ng
brew install john-jumbo
brew install netcat6
brew install nmap

# Install Homebrew-Cask
brew install caskroom/cask/brew-cask

brew cask install atom
bash atom-install.sh

brew cask install 1password
brew cask install adobe-illustrator-cc
brew cask install adobe-photoshop-cc
brew cask install arduino
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
brew cask install hashcat
brew cask install intellij-idea-ce
brew cask install iterm2
brew cask install keepingyouawake
brew cask install limechat
brew cask install microsoft-office
brew cask install mobile-mouse-server
brew cask install origin
brew cask install pgadmin3
brew cask install postgres
brew cask install spectacle
brew cask install sqlitebrowser
brew cask install steam
brew cask install the-unarchiver
brew cask install transmission
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc
brew cask install wireshark

brew tap sbdchd/sleep-restart-shutdown
brew cask install sleep
brew cask install restart
brew cask install shutdown

# Install Vim Plug Package Manager
bash vimplug-install.sh

# Install TMUX Package Manager
bash tpm-install.sh

bash osx-defaults.sh
