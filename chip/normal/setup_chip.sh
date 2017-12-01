#!/bin/bash

function pause_prompt {
	read -p $@;
}

sudo apt-get update;
sudo apt-get install -y \
	autossh

pause_prompt "Just ran Apt-get Update. Next is SSHKEYGEN"

temp=$(date +%s | sha256sum | base64 | head -c 6)
sudo sed -i.bak "s/chip/chip-$temp/" /etc/hostname
sudo sed -i.bak "s/chip/chip-$temp/" /etc/hosts
sudo hostname "chip-$temp"

# ----- Create and Add SSH Keys -----
ssh-keygen -t rsa -b 2048 -N "" -f .ssh/id_rsa
ssh-copy-id rynojvr@rynojvr.com

pause_prompt "Finished SSHKEYGEN stuff. AutoSSH config next"

# ----- Setup AutoSSH -----
sudo cp autossh.service /lib/systemd/system/
sudo mkdir /root/bin
sudo cp root/bin/start_autossh.sh /root/bin/
sudo chmod +x /root/bin/start_autossh.sh
sudo systemctl enable autossh

pause_prompt "Finished setting up AutoSSH"
