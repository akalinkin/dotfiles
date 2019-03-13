#!/bin/bash

USER="$(whoami)";
USERHOME="/home/$USER";
DOTFILESDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Current user: $USER"
echo "User home directory: $USERHOME";
echo "Dotfiles directory: $DOTFILESDIR";

function linkDotfiles() {
  echo "Linkin dotfiles:";

  # .aliases
  FILE=".aliases";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;

  # .vimrc
  FILE=".vimrc";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;

  # .bashrc
  FILE=".bashrc";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;

  # .zshrc
  FILE=".zshrc";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;
  
  # .muttrc
  FILE=".muttrc";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;

  # .tmux.conf
  FILE=".tmux.conf";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;

  # .taskrc
  FILE=".taskrc";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;

  # .taskrc.holidays.ru-RU.rc
  FILE=".taskrc.holidays.ru-RU.rc";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;

  # .timewarrior.holidays.ru-RU
  FILE=".timewarrior.holidays.ru-RU";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;

  # .scripts folder
  DIR=".scripts";
  read -p "This action will override your \"~/$DIR\" directory (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" directory";
    rm -rf "$USERHOME/$DIR";
    ln -sv "$DOTFILESDIR/$DIR" "$USERHOME/$DIR";
    echo "DONE";
  fi;

  # i3 folder
  DIR=".config/i3";
  read -p "This action will override your \"~/$DIR\" directory (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" directory";
    rm -rf "$USERHOME/$DIR";
    ln -sv "$DOTFILESDIR/i3" "$USERHOME/$DIR";
    echo "DONE";
  fi;

}

linkDotfiles;

unset linkDotfiles;
