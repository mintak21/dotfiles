#!/bin/bash

# Get user input
read -p "Enter your Git user name: " git_user_name
read -p "Enter your Git user email: " git_user_email

# Create .gitconfig from .gitconfig_base
sed -e "s/REP_NAME/$git_user_name/" -e "s/REP_EMAIL/$git_user_email/" .gitconfig_base > ~/.gitconfig

# Copy .gitignore
cp -f .gitignore ~/.gitignore

# copy .vimrc to ~/.vimrc
cp -f vim/.vimrc ~/.vimrc

# copy .commit_template to HOME directory
cp -f git/.commit_template ~/.commit_template

echo "Git configuration complete."

# setup warp theme
mkdir -p $HOME/.warp
cd $HOME/.warp/
git clone https://github.com/warpdotdev/themes.git
mkdir -p $HOME/.warp/themes/custom
cp -rf .warp/themes/custom/ $HOME/.warp/themes/custom/
echo "Warp theme setup complete."