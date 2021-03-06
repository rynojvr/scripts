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

sudo apt-get install -y build-essentials
sudo apt-get install -y make gcc

# --------- Mana ---------

cd $INSTALL_DIR
git clone https://github.com/rynojvr/mana
cd mana
git submodule init
git submodule update
sudo ./chip-install.sh

sudo apt-get install -y vim
