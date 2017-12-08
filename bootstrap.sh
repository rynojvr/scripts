#!/bin/bash

# Get the SaltStack bootstrap
if command -v curl 2>/dev/null; then
	curl -L https://bootstrap.saltstack.com -o install_salt.sh
else
	wget https://bootstrap.saltstack.com -O install_salt.sh
fi

sudo sh install_salt.sh -A 159.203.180.72
