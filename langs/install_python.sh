#!/bin/sh
# 初回インストール 引数のバージョンをグローバル設定とする。

VERSION=$1

echo $VERSION

if [ -z "$VERSION" ]; then
    printf '\033[31m%s\033[m\n' 'unknown version!!'
    exit 1
fi

printf '\033[32m%s\033[m\n' 'start install python.'

pyenv install $VERSION
pyenv global $VERSION
pyenv rehash

printf '\033[36m%s\033[m\n' 'end installation'
