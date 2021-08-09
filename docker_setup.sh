#!/bin/bash
# Change this if you want the server to respond to DNS requests on a different NIC
NIC="eth0"

name="dns-server"

MY_IP=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

docker kill $name
docker rm $name

/usr/bin/docker run \
  -v="$SCRIPTPATH/dnsmasq.hosts:/dnsmasq.hosts" \
  --name=$name \
  -p=$MY_IP:53:5353/udp \
  --restart=always \
  -d programster/dnsmasq
