#!/bin/bash

echo "------------------------------"
echo "     Har's System Setup"
echo "------------------------------"
echo "Setting up symlinks:"
cd $HOME
echo "... bashrc"
rm .bashrc
ln -s linux-config/.bashrc 

echo "... vim"
ln -s linux-config/.vim 
ln -s linux-config/.vimrc

echo "... adding vim plugins"
cd $HOME/.vim/bundle
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/tpope/vim-fugitive

echo "... tmux"
cd $HOME
ln -s linux-config/.tmux
ln -s linux-config/.tmux.conf

echo "Sourcing new bashrc..."
source $HOME/.bashrc

echo "------------------------------"
echo "Setting up git:"
cd linux-config
git config --global user.name   "Harlan Shoop"
git config --global user.email  "harlan@kstechnologies.com"
git config --global color.ui    "auto"
git config --global core.editor "vim"
git config credential.helper    store

# list updated config
git config --global -l

echo "------------------------------"
echo "            EOF"
echo "------------------------------"
echo ""
