#!bin/sh

# MacOSを前提
# 基本的にシンボリックリンクを作成
# 存在している場合も強制的に上書きを行う
dirName="dotfiles"

function backup() {
	if [ -e $HOME/.bashrc ]; then
		cp -f $HOME/.bashrc $HOME/.bashrc.bk
		printf '\033[32m%s\033[m\n' 'bashrc has backuped'
	fi
	if [ -e $HOME/.bash_profile ]; then
		cp -f $HOME/.bash_profile $HOME/.bash_profile.bk
		printf '\033[32m%s\033[m\n' 'bash_profile has backuped'
	fi
}

function deploy_basic() {
	printf '\033[91m%s\033[m\n' 'start deploy basic...'

	backup
	ln -fnsv $HOME/${dirName}/bash/.bashrc $HOME/.bashrc	 # bashrc
	ln -fnsv $HOME/${dirName}/bash/.bash_profile $HOME/.bash_profile # bash_profile
	ln -fnsv $HOME/${dirName}/vim/.vimrc $HOME/.vimrc    # vim

	printf '\033[36m%s\033[m\n' 'end deploy basic'
}

function deploy_git() {
	printf '\033[91m%s\033[m\n' 'start deploy git...'

	# gitconfigはnameとemailを引数指定させる
	cat $HOME/${dirName}/git/.gitconfig_base | sed -e "s|REP_NAME|${1}|" | sed -e "s|REP_EMAIL|${2}|" > $HOME/${dirName}/git/.gitconfig
	ln -fnsv $HOME/${dirName}/git/.gitconfig $HOME/.gitconfig
	ln -fnsv $HOME/${dirName}/git/.gitignore $HOME/.gitignore

	printf '\033[36m%s\033[m\n' 'end deploy git'
}

function deploy_vscode() {
	printf '\033[91m%s\033[m\n' 'start deploy vscode...'
	# setting.json / keybindings.json
	ln -fnsv $HOME/${dirName}/vscode $HOME/Library/Application\ Support/Code/User
	printf '\033[36m%s\033[m\n' 'end deploy vscode...'
}

# main
if [ -z "$1" ]; then
	echo "argument1 is mandatory(git name)"
	exit 1
fi
if [ -z "$2" ]; then
	echo "argument2 is mandatory(git email)"
	exit 1
fi

deploy_basic
deploy_git "$1" "$2"
deploy_vscode
printf '\033[92m%s\033[m\n' '===setup ended==='
