#!/bin/sh

for IP in $(cat ip-addresses.txt); do
    echo '----- NEXT -----';
    # ping quietly, wait max 2s for reply, try 2 times
    ping -q -w 2 -c 2 $IP;
done

