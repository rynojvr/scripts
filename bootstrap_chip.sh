#!/bin/bash

if [ "$(id -u)" -ne "0" ]; then
	echo "CHIP Bootsrap script must be run as root"
	exit 1
fi

function send {
	echo $1 > /dev/ttyUSB0
	sleep 5
}

# ----- Login -----
send "chip"
send "chip"

# ----- Connect to initial WiFi -----
send "sudo nmcli device wifi connect <SSID> password <PASSWORD>"
send "chip" # sudo password

# ----- Update and install git to grab remaining scripts -----
send "sudo apt-get update; sudo apt-get install -y git;"
