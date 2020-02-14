#!/usr/bin/env bash

set -euo pipefail

source ~/.dotfiles/scripts/core/log.sh

section "> Set defaults"

# http://osxdaily.com/2011/01/26/change-the-screenshot-save-file-location-in-mac-os-x/
defaults write com.apple.screencapture location ~/Pictures/

# https://www.defaults-write.com/expand-save-panel-default/
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# https://www.defaults-write.com/display-the-file-extensions-in-finder/
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# https://infinitediaries.net/os-x-choose-between-the-character-accents-popup-and-key-repeat-when-holding-down-a-key/
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain KeyRepeat -int 2
