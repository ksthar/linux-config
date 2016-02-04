#!/bin/bash

echo "Install Delorean Dark..."
sudo add-apt-repository ppa:noobslab/themes
sudo apt-get update
sudo apt-get install delorean-dark
echo ""
echo "Install Software Center elements..."
cd /usr/share/software-center/ui/gtk3/css/ && sudo mv softwarecenter.css softwarecenter.css.backup
cd /usr/share/software-center/ui/gtk3/art/ && sudo mv stipple.png stipple.png.backup
cd && wget -O softwarecenter.css http://drive.noobslab.com/data/themes/delorean-dark-3.10/softwarecenter.css
sudo mv softwarecenter.css /usr/share/software-center/ui/gtk3/css/
cd && wget -O stipple.png http://drive.noobslab.com/data/themes/delorean-dark-3.10/stipple.png
sudo mv stipple.png /usr/share/software-center/ui/gtk3/art/
echo ""
echo "Installation complete."

