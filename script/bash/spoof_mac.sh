#!/bin/bash

# spoof MAC addr - sudo
# take network interface down, edit ethernet MAC addr

MAC-ADDR="00:08:74:F4:A4:95"
echo "net interface down"
echo "change MAC addr to $MAC-ADDR"
ifconfig wlan0 down
ifconfig eth0 down
ifconfig eth0 hw ether $MAC-ADDR
ifconfig eth0 up

