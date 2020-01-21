# LocalDockerDns

Setup of a Local DNS Service on a Docker Machine for ChromeOs

This repository is an adaptation from [programster/docker-dnsmasq](https://github.com/programster/docker-dnsmasq)
to be used mainly on chromeOs devices.

### Requirements
- Linux enabled [Setting up linux on ChromeOs](https://support.google.com/chromebook/answer/9145439?hl=en)
- Docker Installed [Setting up docker](https://pages.github.com/)

### Before setting up
Make sure that you don't have any application using port 53.
```
$ sudo systemctl stop systemd-resolved
 ```

### Installation 

Create hosts file and edit it as you need 
(the content should be the same as you would setup on your /etc/hosts)
* The ip should be your linux container IP, and not 127.0.0.1
```
$ touch ./dnsmasq.hosts
```

Execute setup file:
```
$ sh ./docker_setup.sh
```

Once done, make sure the docker container is up and running with:
```
$ docker ps 
```

You should se a line like:
```
bcf4cfe89dd0        programster/dnsmasq        "/usr/sbin/dnsmasq -d"   2 hours ago         Up 10 minutes       5353/tcp, 0.0.0.0:53->5353/udp                 dns-server
```

Once is set, make sure to update your local DNS to use your docker image.

### Updating DNS Preference on ChromeOs

To update the DNS servers preference:
1. Go to Settings
2. Network
3. Click on your connection (Wifi or Ethernet)
4. Network
5. Name Servers
6. Copy the IP that shows up as "Automatic names servers"
7. Under "Custom names servers", set the first one to be your linux IP and the following ones matching the order they were on step 6.

It should work like this. If not, try wait a bit or open your browser in a anonymous tab.


### Remarks
To check your linux container ip, execute on terminal:
```
$ ip a
```
and search for the ip using Eth0

