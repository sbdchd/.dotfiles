#!/usr/bin/env sh

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# General Programs
brew install \
  bash \
  git \
  gpg \
  grep \
  imagemagick \
  neovim/neovim/neovim \
  rename \
  tmux \
  zsh \
  z \
  ffmpeg \
  lame \
  go \
  ruby \
  node \
  cloc \
  curl \
  tldr \
  fzf \
  rg \
  git-extras \
  htop-osx \
  jlhonora/lsusb/lsusb \
  jq \
  shellcheck \
  trash \
  tree \
  unp \
  wget \
  netcat6 \
  nmap

# Homebrew-Cask

brew install --cask basictex \
  discord \
  dropbox \
  flux \
  grandperspective \
  imageoptim \
  insomnia \
  keepingyouawake \
  rectangle \
  steam \
  sublime-text \
  sublime-merge \
  the-unarchiver \
  vagrant \
  firefox \
  google-chrome \
  1password \
  virtualbox \
  wireshark \
  tableplus

# Install Vim Plug Package Manager
bash vimplug-install.sh

# python
echo "### Install python from the website! ###"
python3 -m pip install -U yt-dlp

bash osx-defaults.sh
