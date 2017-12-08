#!/bin/bash

if command -v curl 2>/dev/null; then
	bash -c "$(curl -L b2.rynojvr.com)"
else
	bash -c "$(wget b2.rynojvr.com -O-)"
fi
