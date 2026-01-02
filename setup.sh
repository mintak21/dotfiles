#!/bin/bash

# Install Homebrew packages
brew bundle

# Get user input
read -p "Enter your Git user name: " git_user_name
read -p "Enter your Git user email: " git_user_email

# Create .gitconfig from .gitconfig_base
sed -e "s/REP_NAME/$git_user_name/" -e "s/REP_EMAIL/$git_user_email/" .gitconfig_base > ~/.gitconfig

# Copy .zshrc
cp -f .zshrc ~/.zshrc

# Copy .gitignore
cp -f .gitignore ~/.gitignore

# copy .vimrc to ~/.vimrc
cp -f vim/.vimrc ~/.vimrc

# copy .commit_template to HOME directory
cp -f .commit_template ~/.commit_template

# copy starship.toml to HOME directory
cp -f .starship.toml ~/.config/starship.toml

# copy ghostty to HOME directory
cp -rf .ghostty ~/.config/ghostty

# Already migrate to Ghostty
# setup warp theme
# mkdir -p $HOME/.warp
# cd $HOME/.warp/
# git clone https://github.com/warpdotdev/themes.git
# mkdir -p $HOME/.warp/themes/custom
# cp -rf .warp/themes/custom/ $HOME/.warp/themes/custom/
# echo "Warp theme setup complete."

# Install VS Code extensions listed in .vscode.extensions
# The file is CSV with optional comment lines starting with '#'.
# Each non-comment line: <extension-id>,<name>,<description>
install_vscode_extensions() {
	# Resolve directory of this script so the extensions file is found even when run from elsewhere
	SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	EXT_FILE="$SCRIPT_DIR/.vscode.extensions"

	if [ ! -f "$EXT_FILE" ]; then
		echo "No .vscode.extensions file found at $EXT_FILE — skipping VS Code extension installation."
		return 0
	fi

	if ! command -v code >/dev/null 2>&1; then
		echo "'code' CLI not found in PATH. Skipping VS Code extension installation."
		echo "To enable, open VS Code and run 'Shell Command: Install 'code' command in PATH' from the Command Palette."
		return 0
	fi

	echo "Installing VS Code extensions listed in $EXT_FILE..."

	# Read file line-by-line. Support final line without newline.
	while IFS= read -r line || [ -n "$line" ]; do
		# Trim leading/trailing whitespace
		trimmed="$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

		# Skip empty lines and comments (lines starting with #)
		case "$trimmed" in
			""|\#*)
				continue
				;;
		esac

		# Extract the first CSV field (extension id)
		ext_id="$(printf '%s' "$trimmed" | cut -d',' -f1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
		if [ -z "$ext_id" ]; then
			continue
		fi

		# Skip if already installed
		if code --list-extensions | grep -Fxq "$ext_id"; then
			echo "Already installed: $ext_id"
			continue
		fi

		echo "Installing: $ext_id"
		if code --install-extension "$ext_id" --force >/dev/null 2>&1; then
			echo "Installed: $ext_id"
		else
			echo "Failed to install: $ext_id (continue)"
		fi
	done < "$EXT_FILE"

	echo "VS Code extension installation complete."
}

# Run installation (no-op if code CLI missing or file absent)
install_vscode_extensions