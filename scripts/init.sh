#!/bin/sh
# deploy前提

function install_brew_formulas() {
	printf '\033[91m%s\033[m\n' 'start install home-brew'
	#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # deprecated
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	printf '\033[36m%s\033[m\n' 'success homebrew install'

	printf '\033[91m%s\033[m\n' 'start bundle'
	brew upgrade
	brew bundle --file ../brew/Brewfile
	printf '\033[36m%s\033[m\n' 'end bundle install'
}

function install_fonts() {
  # Ricty
  # TODO そのままだとバッククオートが埋もれる(FontForge入れるのがメンドウなのでいったんおいとき)
  # 気になる場合は https://qiita.com/uKLEina/items/ff0877871fc425952b92 を参照して修正
  cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
  fc-cache -vf
}

function install_vscode_extensions() {
	# VSCode拡張機能インストール
  printf '\033[91m%s\033[m\n' 'start install vscode extensions'
	cat ../vscode/extensions | while read line
	do
		code --install-extension ${line}
	done
  printf '\033[36m%s\033[m\n' 'end install vscode extensions'
}

cd `dirname $0`
#install_brew_formulas
install_vscode_extensions
#install_fonts
