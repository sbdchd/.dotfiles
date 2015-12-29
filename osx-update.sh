#! /bin/sh

brew update 
brew upgrade
brew cleanup 
brew cask cleanup

bash atom-update.sh
