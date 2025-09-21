#!/bin/bash

# Create SSH Key
ssh-keygen -t ed25519

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Packages
brew bundle --global

# Setup Packages
volta install node
volta install npm
volta setup

# Install Claude Code
npm install -g @anthropic-ai/claude-code

