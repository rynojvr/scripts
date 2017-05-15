#!/bin/bash

useradd -d /home/rynojvr rynojvr
passwd
visudo

su - rynojvr -c "mkdir -p /home/rynojvr/dev/github/rynojvr; git clone https://github.com/rynojvr/scripts; cd scripts/; bash setup.sh"
