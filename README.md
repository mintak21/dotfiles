## Dot Files Storehouse

How To Use

1. Homebrew〜gitを以下コマンドでインストール

```sh
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git
``` 

2. リポジトリをcloneし、dotfileのセットアップ

```sh
cd ~
git clone git@github.com:mintak21/dotfiles.git
make setup GIT_NAME={GIT_NAME} GIT_EMAIL={GIT_EMAIL}
make bash_completion
```

3. VSCodeでcodeコマンドをPATHに通した後、VSCodeの設定と拡張機能をインストール
```sh
make vscode_setup
```

