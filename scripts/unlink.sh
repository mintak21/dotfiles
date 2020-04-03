#!/bin/sh

# deployではったシンボリックリンクを削除
dotfiles=(
  .bashrc
  .bash_profile
  .gitconfig
  .gitignore
  .vimrc
)

for file in "${dotfiles[@]}"; do
  unlink $HOME/${file}
done
