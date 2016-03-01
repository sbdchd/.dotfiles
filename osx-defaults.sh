#!/usr/bin/env sh

# Make delete work for navigating back a page in safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES

# Enable key repeat system wide
defaults write -g ApplePressAndHoldEnabled -bool false

# Decrease the delay when switching between desktops/workspaces
defaults write com.apple.dock workspaces-edge-delay -float 0.1

# https://github.com/necolas/dotfiles/blob/master/bin/osxdefaults
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

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES
