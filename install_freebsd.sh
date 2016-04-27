#!/usr/local/bin/bash
# -------------------------------------------------------------------
# @file     install.sh
# @brief    This script is designed to get a FreeBSD system up and
#           running quickly, automating routing install tasks.
#           
# @author   Harlan Shoop
# @version  1.0
# @date     2016-01-26
# -------------------------------------------------------------------
#
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

# Start up message
printf "\033[034m";
echo "-------------------------------------------------------------------"
echo "                      Har's System Setup"
echo "-------------------------------------------------------------------"
printf "\033[036m";
echo "This script is tailored for FreeBSD, and uses FreeBSD-specific applications. " 
echo "This script may not work with other OS's.  "
echo ""
echo "This script will add software and configure your machine in a specific way.  "
echo "Please review the script prior to running it."
echo ""
echo "Also, before running this script, ensure your account has sudo privileges"
echo "and you are running bash (other shells may not work)."
echo ""
echo "              Press [ENTER] to continue, Ctrl-C to quit..."
read
echo ""

# Setup some working variables
export CONFDIR=$HOME/linux-config
export CONFBRANCH=master

# Install apps here; make sure dependencies are handled now
printf "\033[037m";
echo "> (1 of 5) Installing Standard Apps:"
echo "-------------------------------------------------------------------"
printf "\033[032m";

echo "... git"
printf "\033[036m";
sudo pkg install git
printf "\033[032m";

echo "... vim"
printf "\033[036m";
sudo pkg install vim
printf "\033[032m";

echo "... tmux"
printf "\033[036m";
sudo pkg install tmux
printf "\033[032m";
echo ""

# Setup git config
printf "\033[037m";
echo "> (2 of 5) Setting up git:"
echo "-------------------------------------------------------------------"
printf "\033[036m";
cd $CONFDIR
git config --global user.name   "Harlan Shoop"
git config --global user.email  "harlan@kstechnologies.com"
git config --global color.ui    "auto"
git config --global core.editor "vim"
git config credential.helper    store

# list updated config
git config --global -l
echo ""

# Install any required repos; here we're installing the linux-config repo
# this is circular since we can only get this from installing linux-config,
# but it covers the case where all we have is this script.  We may adjust
# this later.
printf "\033[037m";
echo "> (3 of 5) Installing config system:"
echo "-------------------------------------------------------------------"
printf "\033[032m";
echo "... linux-config"
printf "\033[036m";

# Update linux-config
cd $CONFDIR
git pull origin $CONFBRANCH

printf "\033[032m";
echo ""

# Setup all the symlinks to the included configs
printf "\033[037m";
echo "> (4 of 5) Setting up symlinks:"
echo "-------------------------------------------------------------------"
printf "\033[032m";

echo "... .bashrc"
printf "\033[036m";
ln -s $CONFDIR/.bashrc  $HOME/.
printf "\033[032m";

echo "... .vim"
printf "\033[036m";
ln -s $CONFDIR/.vim  $HOME/.
printf "\033[032m";

echo "... .vimrc"
printf "\033[036m";
ln -s $CONFDIR/.vimrc $HOME/.
printf "\033[032m";

echo "... creating vim directories"
printf "\033[036m";
# Create directory for pathogen plugins
mkdir $HOME/.vim/bundle

# Create tmp directory for backups and swap files
mkdir $HOME/.vim/tmp
printf "\033[032m";

echo "... install favorite vim plugins"
printf "\033[036m";

# Install favorite plugins
git  clone  https://github.com/scrooloose/nerdtree  $HOME/.vim/bundle/nerdtree
git  clone  https://github.com/godlygeek/tabular    $HOME/.vim/bundle/tabular
git  clone  https://github.com/tpope/vim-fugitive   $HOME/.vim/bundle/vim-fugitive
printf "\033[032m";

echo "... .tmux"
printf "\033[036m";
ln -s $CONFDIR/.tmux $HOME/.
printf "\033[032m";

echo "... .tmux.conf"
printf "\033[036m";
ln -s $CONFDIR/.tmux.conf $HOME/.
echo ""

printf "\033[037m";
echo "> (5 of 5) Sourcing new bashrc..."
echo "-------------------------------------------------------------------"
printf "\033[032m";
source $HOME/.bashrc
echo "... Done"
echo ""

printf "\033[034m";
echo "-------------------------------------------------------------------"
echo "                              EOF"
echo "-------------------------------------------------------------------"
printf "\033[037m";
echo ""
cd $HOME
