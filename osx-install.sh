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
brew install ruby
brew install rbenv
brew install node
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
brew install lolcat

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
brew cask install docker
brew cask install postgres
brew cask install transmission
brew cask install 1password
brew cask install dropbox
brew cask install iterm2
brew cask install remote-desktop-connection # compatibility issues with later os versions - may need to edit formula manually
brew cask install atom
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
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install TMUX Package Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# OSX Defaults

# Make delete work for navigating back a page in safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES

# Decrease the delay when switching between desktops/workspaces
defaults write com.apple.dock workspaces-edge-delay -float 0.1

# https://github.com/necolas/dotfiles/blob/master/bin/osxdefaults
# lots of culling of unnecessary/nonfunctioning defaults

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Dock: position the Dock on the left
defaults write com.apple.dock orientation left

# Dock: show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Dock: make icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Dock: use the scale effect for window minimizing
defaults write com.apple.dock mineffect scale

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Finder: disable window and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: use list view in all windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Screen: require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screen: save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Screen: disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Screen: enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Disks: avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disks: disable Time Machine prompts
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disks: disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

for app in "Dashboard" "Dock" "Finder" "SystemUIServer" "Terminal" "iTunes"; do
    killall "$app" > /dev/null 2>&1
done
