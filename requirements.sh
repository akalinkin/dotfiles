#!/bin/bash 

if [ "$EUID" == 0 ]; then
  echo "Please don't use sudo to run this script. Run it as regular user"
  exit 1
fi

# Basic dependencies
sudo apt-get install -y git python3-pip tmux vim urlview wmctrl taskwarrior
# Vundle for Vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


# Time tracking hook
pip3 install taskwarrior-time-tracking-hook
mkdir -p ~/.task/hooks
ln -s `which taskwarrior_time_tracking_hook` ~/.task/hooks/on-modify.timetracking
