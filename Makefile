GIT_EMAIL=mintak21@gmail.com

.PHONY: bash_completion setup vscode_setup

bash_completion:
	sh bash/bash_completion.sh

setup:
	sh setup_dotfiles.sh {GIT_NAME} {GIT_EMAIL}

vscode_setup:
	sh setup_vscode.sh

