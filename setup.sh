#!/bin/bash

# Install Homebrew packages
brew bundle

# Get user input
read -p "Enter your Git user name: " git_user_name
read -p "Enter your Git user email: " git_user_email

# Create .gitconfig from .gitconfig_base
sed -e "s/REP_NAME/$git_user_name/" -e "s/REP_EMAIL/$git_user_email/" .gitconfig_base > ~/.gitconfig

# Copy to $HOME
cp -f .zshrc ~/.zshrc
cp -f .gitignore ~/.gitignore
cp -f vim/.vimrc ~/.vimrc
cp -f .commit_template ~/.commit_template

# Copy to $HOME/.config
cp -f .starship.toml ~/.config/starship.toml
cp -rf .ghostty ~/.config/ghostty
cp -rf .zabrze ~/.config/zabrze
cp -rf .claude/skills ~/claude/skills
cp -rf .claude/sound ~/claude/sound
cp -rf .claude/mcp.json ~/claude/mcp.json
cp -rf .claude/settings.json ~/claude/settings.json
cp -rf .vscode.settings.json ~/Library/Application\ Support/Code/User/settings.json