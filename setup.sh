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

echo "Git configuration complete."

