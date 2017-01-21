#!/bin/bash

if [ "$(id -u)" -ne "0" ]; then
	echo "CHIP Bootsrap script must be run as root"
	exit 1
fi

if [ ! -f bootstrap.network ]; then
	echo "Must create file 'bootstrap.network' containing single lines of
	SSID=\"<NETWORK_SSID>\"
	PSK=\"<NETWORK_PSK>\""
	exit 1
fi

# Get the network configuration
# TODO: validate network fields
# TODO: only use when necessary
source bootstrap.network

function send {
	echo $1 > /dev/ttyUSB0
	sleep ${2:-2}
}

# ----- Login -----
send "chip"
send "chip" 5

#send "vi bootstrap.sh"
#send "i"

send "echo 'nmcli device wifi connect $SSID password $PSK;' > bootstrap.sh"
send "echo 'apt-get update;' >> bootstrap.sh"
send "echo 'apt-get -y --force-yes install git;' >> bootstrap.sh"
send "echo 'git clone https://github.com/rynojvr/scripts' >> bootstrap.sh"
send "echo 'rm bootstrap.sh;' >> bootstrap.sh"

send "sudo bash bootstrap.sh"
send "chip"

# ----- Connect to initial WiFi -----
#send "sudo nmcli device wifi connect NETGEAR85 password freshcartoon223"
#send "chip" # sudo password

# ----- Update and install git to grab remaining scripts -----
#send "sudo apt-get update; sudo apt-get install -y git;"
