#!/bin/bash

sudo apt-get update;
#sudo apt-get install -y \

# ----- Create and Add SSH Keys -----
ssh-keygen -t rsa -b 2048 -N "" -f .ssh/id_rsa
ssh-copy-id rynojvr@rynojvr.com	

# ----- Setup AutoSSH -----
sudo cp autossh.service /lib/systemd/system/
sudo mkdir /root/bin
sudo cp root/bin/start_autossh.sh /root/bin/
sudo chmod +x /root/bin/start_autossh.sh
sudo systemctl enable autossh


