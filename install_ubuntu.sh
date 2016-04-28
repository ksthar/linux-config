
# -------------------------------------------------------------------
# @file     install.sh
# @brief    This script is designed to get an Ubuntu system up and 
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
echo "This script is tailored to an Ubuntu system.  If are using something"
echo "else, you may need to make adjustments."
echo ""
echo "              Press [ENTER] to continue, Ctrl-C to quit..."
read
echo ""

# Install apps here; make sure dependencies are handled now
printf "\033[037m";
echo "> (1 of 6) Installing Standard Apps:"
echo "-------------------------------------------------------------------"
printf "\033[032m";
echo "... (prep) update"
printf "\033[036m";
sudo apt-get update
printf "\033[032m";
echo ""
echo "... (prep) upgrade"
printf "\033[036m";
sudo apt-get -y upgrade
printf "\033[032m";
echo ""
echo "... (prep) autoremove"
printf "\033[036m";
sudo apt-get -y autoremove
printf "\033[032m";
echo ""
echo "... git"
printf "\033[036m";
sudo apt-get -y install git
printf "\033[032m";
echo ""
echo "... node"
printf "\033[036m";
sudo apt-get -y install node
printf "\033[032m";
echo ""
echo "... nodejs-legacy"
printf "\033[036m";
sudo apt-get -y install nodejs-legacy
printf "\033[032m";
echo ""
echo "... npm"
printf "\033[036m";
sudo apt-get -y install npm 
printf "\033[032m";
echo ""
echo "... vim-nox"
printf "\033[036m";
sudo apt-get -y install vim-nox
printf "\033[032m";
echo ""
echo "... tmux"
printf "\033[036m";
sudo apt-get -y install tmux
printf "\033[032m";
echo ""

# Setup git config
printf "\033[037m";
echo "> (2 of 6) Setting up git:"
echo "-------------------------------------------------------------------"
printf "\033[036m";
cd $HOME/linux-config
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
echo "> (3 of 6) Installing repos:"
echo "-------------------------------------------------------------------"
printf "\033[032m";
echo "... linux-config"
printf "\033[036m";
cd $HOME
git clone https://github.com/ksthar/linux-config.git
# If we already have it installed, let's update to the latest
cd $HOME/linux-config
git pull origin master
printf "\033[032m";
echo ""

# Setup all the symlinks to the included configs
printf "\033[037m";
echo "> (4 of 6) Setting up symlinks:"
echo "-------------------------------------------------------------------"
printf "\033[032m";
cd $HOME
echo "... .bashrc"
printf "\033[036m";
rm .bashrc
ln -s linux-config/.bashrc 
printf "\033[032m";
echo ""
echo "... .vim"
printf "\033[036m";
ln -s linux-config/.vim 
printf "\033[032m";
echo ""
echo "... .vimrc"
printf "\033[036m";
ln -s linux-config/.vimrc
printf "\033[032m";
echo ""
echo "... adding vim plugins"
printf "\033[036m";
# need to check if bundle exists, if not create it
if [ -d $HOME/.vim/bundle ]; then
    # do nothing at this point
else
    mkdir $HOME/.vim/bundle
fi
cd $HOME/.vim/bundle
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/tpope/vim-fugitive
git clone https://github.com/godlygeek/tabular

printf "\033[032m";
echo ""
echo "... .tmux"
printf "\033[036m";
cd $HOME
ln -s linux-config/.tmux
printf "\033[032m";
echo ""
echo "... .tmux.conf"
printf "\033[036m";
cd $HOME
ln -s linux-config/.tmux.conf
echo ""

printf "\033[037m";
echo "> (5 of 6) Sourcing new bashrc..."
echo "-------------------------------------------------------------------"
printf "\033[032m";
source $HOME/.bashrc
echo "... Done"
echo ""

printf "\033[037m";
echo "> (6 of 6) Patching motd..."
echo "-------------------------------------------------------------------"
printf "\033[032m";
sudo patch /etc/update-motd.d/00-header $HOME/linux-config/patch-etc-update-motd-d-00-header

printf "\033[034m";
echo "-------------------------------------------------------------------"
echo "                              EOF"
echo "-------------------------------------------------------------------"
printf "\033[037m";
echo ""
cd $HOME
