## Dot Files Storehouse

How To Use

1. Homebrewを〜gitを以下コマンドでインストール

```sh
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git
``` 

2. リポジトリをcloneし、dotfileのセットアップ

```sh
cd ~
git clone git@github.com:mintak21/dotfiles.git
sh setup_dotfiles.sh
```

3. VSCodeでcodeコマンドをPATHに通した後、VSCodeの設定と拡張機能をインストール
```sh
sh setup_vscode.sh
```
