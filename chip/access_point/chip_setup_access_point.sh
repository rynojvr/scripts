#!/bin/bash

function sudo_write () {
	echo "$2" | sudo tee -a $1 > /dev/null
}

sudo apt-get update;
sudo apt-get install -y hostapd dnsmasq dhcpcd5

# ----- /etc/dhcpcd.conf -----

file=/etc/dhcpcd.conf
echo "Setting up $file"

sudo_write $file ''
sudo_write $file 'interface wlan2'
sudo_write $file 'static ip_address=192.168.42.1/24'
sudo_write $file 'static routers=192.168.42.0'

sudo service dhcpcd restart

# ------ /etc/hostapd/hostapd.conf ------

file=/etc/hostapd/hostapd.conf
echo "Setting up $file"

sudo_write $file ''
sudo_write $file 'interface=wlan2'
sudo_write $file 'driver=nl80211'
sudo_write $file ''
sudo_write $file 'hw_mode=g'
sudo_write $file 'channel=6'
sudo_write $file 'ieee80211n=1'
sudo_write $file 'wmm_enabled=1'
sudo_write $file 'ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]'
sudo_write $file 'macaddr_acl=0'
sudo_write $file 'ignore_broadcast_ssid=0'
sudo_write $file ''
sudo_write $file '# Use WPA2'
sudo_write $file 'auth_flags=1'
sudo_write $file 'wpa=2'
sudo_write $file 'wpa_key_mgmt=WPA-PSK'
sudo_write $file 'rsn_pairwise=CCMP'
sudo_write $file ''
sudo_write $file '# This is the name of the network'
sudo_write $file 'ssid=CHIP-AP'
sudo_write $file '# The network passphrase
sudo_write $file 'wpa_passphrase=nextthing'

# ----- /etc/default/hostapd -----

file=/etc/default/hostapd
echo "Setting up $file"

sudo sed -i 's|#DAEMON_CONF=""|DAEMON_CONF="/etc/hostapd/hostapd.conf"|' $file

# ------ /etc/dnsmasq.conf ------

file=/etc/dnsmasq.conf
echo "Setting up $file"

sudo mv $file $file.orig
sudo_write $file ''
sudo_write $file 'interface=wlan2                                # Use interface wlan2'
sudo_write $file 'listen-address=192.168.42.1                    # Specify the address to listen on'
sudo_write $file 'bind-interfaces                                # Bind to the interface'
sudo_write $file 'server=8.8.8.8                                 # Use Google DNS'
sudo_write $file 'domain-needed                                  # Dont forward short names'
sudo_write $file 'bogus-priv                                     # Drop the non-routed address spaces'
sudo_write $file 'dhcp-range=192.168.42.10,192.168.42.50,12h     # IP range and lease time'

# ----- /etc/sysctl.conf ------

file=/etc/sysctl.conf
echo "Setting up $file"

sudo sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|' $file

# ------ iptables ------

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE  
sudo iptables -A FORWARD -i wlan0 -o wlan2 -m state --state RELATED,ESTABLISHED -j ACCEPT  
sudo iptables -A FORWARD -i wlan2 -o wlan0 -j ACCEPT  

sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

# ------ /etc/rc.local ----- 

file=/etc/rc.local
echo "Setting up $file"

sudo sed -i 's|exit 0||' $file
sudo_write $file 'iptables-restore < /etc/iptables.ipv4.nat'
sudo_write $file 'exit 0'

sudo service hostapd start
sudo service dnsmasq start
