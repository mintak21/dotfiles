#!bin/sh

# MacOSを前提
# 基本的にシンボリックリンクを作成
# 存在している場合も強制的に上書きを行う
cd `dirname $0`
dirName="dotfiles"

function install_homebrew() {
	#そもそもこれたたけている時点で、gitまでは入っている必要がある
	#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle
}

function deploy_basic() {
	echo "start deploy basic..."

	ln -fnsv $HOME/${dirName}/.bashrc $HOME/.bashrc	 # bashrc
	ln -fnsv $HOME/${dirName}/.vimrc $HOME/.vimrc    # vim
	
	echo "end deploy basic"
}

function deploy_git() {
	echo "start deploy git..."

	ln -fnsv $HOME/${dirName}/git/.gitconfig $HOME/.gitconfig
	ln -fnsv $HOME/${dirName}/git/.gitignore $HOME/.gitignore
 
	echo "end deploy git"
}

function deploy_vscode() {
	echo "start deploy vscode..."
	# setting.json / keybindings.json
	ln -fnsv $HOME/${dirName}/vscode $HOME/Library/Application\ Support/Code/User
	echo "end deploy vscode..."
}


function deploy_all() {
	echo "===start All==="
	deploy_basic
	deploy_git
	echo "===setup end==="
}

# main
install_homebrew
deploy_all
