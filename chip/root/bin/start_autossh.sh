#!/bin/bash

until ping -c 1 www.google.com 
do	
	echo "Waiting...";	# No-op; wait until we can ping google
done

/usr/bin/autossh -p 22 -l rynojvr rynojvr.com -N -R *:7000:127.0.0.1:22 -i /root/.ssh/id_rsa 2>&1 >> /tmp/autossh.log &
