#!/bin/bash

# set up configs
mkdir ~/.env
cp ./dotfiles/.bashrc ~
cp ./dotfiles/.vimrc ~
mkdir -p ~/.config/terminator
cp ./dotfiles/terminator-config ~/.config/terminator/config
cp ./db.txt ~/.env
source ~/.bashrc

# run setup script
chmod +x ./kalisetup.sh && ./kalisetup.sh
