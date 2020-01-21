#!/bin/bash
# Change this if you want the server to respond to DNS requests on a different NIC
NIC="eth0"

name="dns-server"

MY_IP=$(ifconfig $NIC | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')

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