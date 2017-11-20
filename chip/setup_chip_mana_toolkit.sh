#!/bin/bash	

INSTALL_DIR=$HOME/dev/github/rynojvr

mkdir -p $INSTALL_DIR
cd $INSTALL_DIR
git clone https://github.com/rynojvr/scripts
cd scripts/

./link-files.sh -v -f

# --------- NodeJS --------- 
# https://nodejs.org/en/download/package-manager/
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo apt-get install build-essentials

# --------- Mana ---------

cd $INSTALL_DIR
git clone https://github.com/rynojvr/mana
cd mana
sudo ./chip-install.sh

sudo apt-get install vim
