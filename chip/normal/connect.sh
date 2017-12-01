#!/bin/bash

function log {
        echo $1 >> connect.log
}

function try_connect {
        #echo "inFunction" >> connect.log
        log "inFunction with log"
        configuredNetworkList=$(cut -d "," -f1 connect.networks)
        for networkName in $configuredNetworkList
        do
                log "Looking for: $networkName"
                networkPassword=$(grep $networkName connect.networks | cut -d "," -f2)
                searchResult=$(nmcli device wifi list | grep $networkName | tr -s ' ')
                log "SearchResult: $searchResult"
                if [ -n "$searchResult" ]
                then
                        log "FOUND CONFIG! $networkName"
                        nmcli device wifi connect $networkName password $networkPassword
                        log "ESTABLISHED CONNECTION TO: [$networkName]"
                fi
        done
}

until ping -c 1 8.8.8.8
do
        try_connect
done
