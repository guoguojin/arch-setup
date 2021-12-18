#!/usr/bin/env bash

cwd=$(dirname "$0")
source $cwd/funcs.sh

git clone https://github.com/klaxalk/i3-layout-manager.git $HOME/code/personal/i3-layout-manager

mkdir -p $HOME/.config/i3
mkdir -p $HOME/bin

backup_and_create $cwd/dotfiles/i3/config $HOME/.config/i3/config
backup_and_create $cwd/dotfiles/i3/i3blocks.conf $HOME/.config/i3/i3blocks.conf
backup_and_create $cwd/dotfiles/i3/Xresources $HOME/.Xresources

echo "Setting up layout manager"
if [ -d $HOME/.config/i3-layout-manager/layouts ]; then
    rm -rf $HOME/i3-layout-manager
fi

ln -s $cwd/layouts/arco $HOME/.config/i3-layout-manager/layouts

if [ -f $HOME/bin/layout_manager.sh ]; then
  rm $HOME/bin/layout_manager.sh
fi

ln -s $HOME/code/personal/i3-layout-manager/layout_manager.sh $HOME/bin/layout_manager.sh


echo "Setting up conky"
backup_and_create $cwd/dotfiles/conky $HOME/.conky

if [ -f $HOME/bin/viewnotes.sh ]; then
  rm $HOME/bin/viewnotes.sh
fi
ln -s $HOME/.conky/viewnotes.sh $HOME/bin/viewnotes.sh
touch $HOME/notes.txt

echo "Setting up autorandr"
yay -S --needed --no-confirm autorandr
sudo systemctl enable autorandr.service
sudo systemctl start autorandr.service

echo "Configuring alacritty"
mkdir -p $HOME/.config/alacritty
backup_and_create $cwd/dotfiles/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

echo "Configuring Polybar"
mkdir -p $HOME/.config/polybar
backup_and_create $cwd/dotfiles/polybar/default/config $HOME/.config/polybar/config
backup_and_create $cwd/dotfiles/polybar/default/launch.sh $HOME/.config/polybar/launch.sh

if [ ! -d $HOME/.config/polybar/scripts ]; then
  ln -s $cwd/dotfiles/polybar/default/scripts $HOME/.config/polybar/scripts
fi
