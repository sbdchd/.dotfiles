#!/usr/bin/env sh

# brew
brew update
brew upgrade
brew cleanup
brew cask cleanup

# python
# http://stackoverflow.com/a/27071962
pip install -U pip
pip install -U $(pip list --outdated | awk '!/Could not|ignored/ {print $1}')

# ruby
gem update

# node
npm update -g

# atom
apm upgrade --no-confirm

# go
sh go-install.sh
