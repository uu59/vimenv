#!/bin/bash

DIR=$(cd $(dirname $0);pwd)

for dotfile in `find $DIR -maxdepth 1 -type f -name ".*" -a -not -name ".git*"`; do
  dst=$HOME/`basename $dotfile`
  if [ -f "$dst" ];then
    echo "$dst exists. skip"
  else
    ln -sf $dotfile $dst
  fi
done

if [ ! -d "$HOME/.vimundo" ];then
  echo "mkdir $HOME/.vimundo for persistent_undo"
  mkdir $HOME/.vimundo
fi

cd $DIR
git submodule update --init
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

read -p "Press Enter for go PlugInstall or C-c"
vim '+PlugInstall' '+qall'
