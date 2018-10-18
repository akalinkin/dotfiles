#!/usr/bin/env bash

USER="$(whoami)";
USERHOME="/home/$USER";
DOTFILESDIR="$USERHOME/dotfiles";

echo "Current user: $USER"
echo "User home directory: $USERHOME";

# cd "$DOTFILESDIR";

function linkDotfiles() {
  echo "Linkin dotfiles:";

  # .aliases
  FILE=".aliases";
  read -p "This action will override your \"~/$FILE\" file (y/n) " -n 1;
  echo "";
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
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing \"~/$FILE\" file";
    rm "$USERHOME/$FILE";
    ln -sv "$DOTFILESDIR/$FILE" "$USERHOME/$FILE";
    echo "DONE";
  fi;


}

linkDotfiles;

unset linkDotfiles;
