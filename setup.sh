#!/bin/bash

DOT_FILES=( .bashrc .gitconfig .gitignore .vimrc)

# シンボリックリンクを作成する
for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
