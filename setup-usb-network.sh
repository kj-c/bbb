#!/bin/sh

# The following should be executed on the bbb
# ifconfig usb0 192.168.7.2
# route add default gw 192.168.7.1


# The following should be executed on the host
#eth0 is the internet facing interface, eth3 is the BeagleBone USB connection

ETH0="enp0s31f6"
ETH2="enx88c255846710"

ifconfig $ETH2 192.168.7.1
iptables --table nat --append POSTROUTING --out-interface $ETH0 -j MASQUERADE
iptables --append FORWARD --in-interface $ETH2 -j ACCEPT
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "Be sure to set /etc/resolv.conf"
echo "nameserver 192.168.7.1 >> /etc/resolv.conf"
echo "nameserver 10.0.8.1"        # >> /etc/resolv.conf
echo "nameserver 8.8.8.8"         # >> /etc/resolv.conf
