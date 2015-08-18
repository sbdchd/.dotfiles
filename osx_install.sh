#!/bin/sh

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git
brew install vim
brew install wget
brew install curl
brew install tmux
brew install reattach-to-user-namespace

brew tap neovim/neovim
brew install --HEAD neovim

# Install Homebrew-Cask
brew install caskroom/cask/brew-cask

brew cask install google-chrome
brew cask install firefox
brew cask install flux
brew cask install virtualbox
brew cask install transmission
brew cask install 1password
brew cask install dropbox
brew cask install iterm2
brew cask install atom
brew cask install vlc
brew cask install alfred
brew cask install keepingyouawake
brew cask install spectacle
# brew cask install microsoft-office # 2011 Version
brew cask install inkscape
brew cask install gimp
brew cask install audacity
brew cask install handbrake
brew cask install limechat
brew cask install the-unarchiver
brew cask install sqlitebrowser
brew cask install mobile-mouse-server
brew cask install go
brew cask install python
brew cask install python3

# Install Fonts
brew tap caskroom/fonts
brew cask install font-inconsolata
brew cask install font-fontawesome


# Make delete work for navigating back a page in safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES

