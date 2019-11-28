#!/bin/sh
# 初回インストール 引数のバージョンをグローバル設定とする。

VERSION=$1

echo $VERSION

if [ -z "$VERSION" ]; then
    printf '\033[31m%s\033[m\n' 'unknown version!!'
    exit 1
fi

printf '\033[32m%s\033[m\n' 'start install ruby.'

rbenv install $VERSION
rbenv global $VERSION
rbenv rehash

printf '\033[36m%s\033[m\n' 'end installation'
