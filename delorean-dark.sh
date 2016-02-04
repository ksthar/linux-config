#!/bin/bash

printf "\033[034m";
echo "-------------------------------------------------------------------"
echo "                    Delorean Dark Theme Install"
echo "-------------------------------------------------------------------"
printf "\033[036m";
echo "This script installs the Delorean Dark theme for the Unity IDE.  It"
echo "also installs the Gnome Tweak Tool to select the theme.  You will "
echo "have to do that after installation."
echo ""
echo "              Press [ENTER] to continue, Ctrl-C to quit..."
read
echo ""
printf "\033[037m";
echo "Install Delorean Dark..."
echo "-------------------------------------------------------------------"
printf "\033[036m";
sudo add-apt-repository ppa:noobslab/themes
sudo apt-get update
sudo apt-get install delorean-dark
echo ""
printf "\033[037m";
echo "Install Software Center elements..."
echo "-------------------------------------------------------------------"
printf "\033[036m";
cd /usr/share/software-center/ui/gtk3/css/ && sudo mv softwarecenter.css softwarecenter.css.backup
cd /usr/share/software-center/ui/gtk3/art/ && sudo mv stipple.png stipple.png.backup
cd && wget -O softwarecenter.css http://drive.noobslab.com/data/themes/delorean-dark-3.10/softwarecenter.css
sudo mv softwarecenter.css /usr/share/software-center/ui/gtk3/css/
cd && wget -O stipple.png http://drive.noobslab.com/data/themes/delorean-dark-3.10/stipple.png
sudo mv stipple.png /usr/share/software-center/ui/gtk3/art/
echo ""
printf "\033[037m";
echo "Install Tweak Tool..."
echo "-------------------------------------------------------------------"
printf "\033[036m";
sudo apt-get -y install gnome-tweak-tool
echo ""
printf "\033[037m";
echo "-------------------------------------------------------------------"
echo "Installation complete."
echo "-------------------------------------------------------------------"
echo ""

