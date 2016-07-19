#!/bin/bash
# -------------------------------------------------------------------
# @file     install.sh
# @brief    This script is designed to get a Mac OS X system up and
#           running quickly, automating routing install tasks.
#           
# @author   Harlan Shoop
# @version  1.0
# @date     2016-05-04
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

# Setup some working variables
export CONFDIR=$HOME/linux-config
export CONFBRANCH=master

# Start up message
printf "\033[034m";
echo "-------------------------------------------------------------------"
echo "                      Har's System Setup"
echo "-------------------------------------------------------------------"
    printf "\033[036m";
    echo "This script is tailored for Mac OS X. This script may not work with"
    echo "other OS's.  "
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

    # Install apps here; make sure dependencies are handled now
    printf "\033[037m";

echo "> (1 of 4) Setting up git:"
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

    # For FreeBSD, symlink /usr/local/bin/bash to /bin/bash; this will allow us to
    # standardize on bash's location for our shell scripts across the BSD's and Linux
    printf "\033[037m";

echo "> (2 of 4) Setting up config symlinks:"
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

echo "> (3 of 4) Sourcing new bashrc..."
echo "-------------------------------------------------------------------"
    printf "\033[036m";
    # Add source command to .profile; this will fix login and tmux behavior
    echo "source $HOME/.bashrc" >> $HOME/.profile
    # Source .bashrc for this session
    source $HOME/.bashrc

    printf "\033[037m";

echo "> (4 of 4) Updating motd..."
echo "-------------------------------------------------------------------"
    printf "\033[036m";
    sudo cp -v $CONFDIR/kst_motd /etc/motd
    echo ""

    printf "\033[034m";

echo "-------------------------------------------------------------------"
echo "                          >> EOF <<"
echo "-------------------------------------------------------------------"
printf "\033[037m";
echo ""
cd $HOME
