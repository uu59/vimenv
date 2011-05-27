#!/bin/bash

# cd $HOME
# git clone https://github.com/uu59/vimenv .vim
# cd .vim
# ./setup.sh

DIR=$(cd $(dirname $0);pwd)

for dotfile in `find $DIR -maxdepth 1 -type f -name ".*"`; do
  dst=$HOME/`basename $dotfile`
  if [ -f "$dst" ];then
    echo "$dst exists. skip"
  else
    ln $dotfile $dst
  fi
done

read -p "go BundleInstall. Press Enter"
vim -c 'BundleInstall'
