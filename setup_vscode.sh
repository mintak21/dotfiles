#!/bin/sh

# Vscode側でcodeをPATHに含めてから実行すること！

function deploy_setting() {
	echo "start deploy vscode..."
	# setting.jsonにシンボリックリンクをはる
        ln -fnsv $HOME/${dirName}/vscode/setting.json $HOME/Library/Application\ Support/Code/User/setting.json
	echo "end deploy vscode..."
}

function install_extensions() {
	# 拡張機能インストール
	cat extensions | while read line
	do
		code --install-extension ${line}
	done
}

# main
deploy_setting
install_extensions
