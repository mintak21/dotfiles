#!/bin/sh
# deploy前提

install_brew_formulas() {
  printf '\033[91m%s\033[m\n' 'start install home-brew'
  #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # deprecated
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  printf '\033[36m%s\033[m\n' 'success homebrew install'

  printf '\033[91m%s\033[m\n' 'start bundle'
  brew upgrade
  brew bundle --file ../brew/Brewfile
  # VSCodeはインストール後、コマンドラインで扱えるようにリンクを張る
  ln -fnsv /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin
  printf '\033[36m%s\033[m\n' 'end bundle install'
}

install_fonts() {
  # Ricty
  # TODO そのままだとバッククオートが埋もれる(FontForge入れるのがメンドウなのでいったんおいとき)
  # 気になる場合は https://qiita.com/uKLEina/items/ff0877871fc425952b92 を参照して修正
  cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
  fc-cache -vf
}

install_vscode_extensions() {
  # VSCode拡張機能インストール
  printf '\033[91m%s\033[m\n' 'start install vscode extensions'
  cat ../vscode/extensions | awk -F "," '{print $1}' | grep -v '^\s*$' | grep -v '^\s*#' | while read extension; do
    code --install-extension ${extension}
  done
  printf '\033[36m%s\033[m\n' 'end install vscode extensions'
}

install_compose_cli() {
  curl -fL https://raw.githubusercontent.com/docker/compose-cli/main/scripts/install/install_linux.sh | sh
}

cd $(dirname $0)
xcode-select --install # これが入っていないと失敗するパッケージがある
install_brew_formulas
install_vscode_extensions
install_fonts
install_compose_cli
