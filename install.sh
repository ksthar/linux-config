#!/bin/bash
# Escaped Color Codes:
# --------------------
# 030m Black
# 031m Red
# 032m Green
# 033m Yellow
# 034m Blue
# 035m Magenta
# 036m Cyan
# 037m White

printf "\033[034m";
echo "------------------------------"
echo "     Har's System Setup"
echo "------------------------------"
printf "\033[037m";
echo "> Installing Standard Apps:"
echo "------------------------------"
printf "\033[032m";
echo "... vim-nox"
printf "\033[036m";
sudo apt-get install vim-nox
printf "\033[032m";
echo "... tmux"
printf "\033[036m";
sudo apt-get install tmux
printf "\033[032m";
echo ""


printf "\033[037m";
echo "> Setting up symlinks:"
echo "------------------------------"
printf "\033[032m";
cd $HOME
echo "... bashrc"
printf "\033[036m";
rm .bashrc
ln -s linux-config/.bashrc 
printf "\033[032m";
echo "... .vim"
printf "\033[036m";
ln -s linux-config/.vim 
printf "\033[032m";
echo "... .vimrc"
printf "\033[036m";
ln -s linux-config/.vimrc
printf "\033[032m";
echo "... adding vim plugins"
printf "\033[036m";
cd $HOME/.vim/bundle
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/tpope/vim-fugitive
printf "\033[032m";
echo "... .tmux"
printf "\033[036m";
cd $HOME
ln -s linux-config/.tmux
printf "\033[032m";
echo "... .tmux.conf"
printf "\033[036m";
cd $HOME
ln -s linux-config/.tmux.conf
echo ""

printf "\033[037m";
echo "> Sourcing new bashrc..."
echo "------------------------------"
printf "\033[032m";
source $HOME/.bashrc
echo "... Done"
echo ""

printf "\033[037m";
echo "> Setting up git:"
echo "------------------------------"
printf "\033[036m";
cd linux-config
git config --global user.name   "Harlan Shoop"
git config --global user.email  "harlan@kstechnologies.com"
git config --global color.ui    "auto"
git config --global core.editor "vim"
git config credential.helper    store

# list updated config
git config --global -l
echo ""

printf "\033[034m";
echo "------------------------------"
echo "            EOF"
echo "------------------------------"
printf "\033[037m";
echo ""
