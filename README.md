# Xubuntu remote access

All procedures aimed at Xubuntu 18.04 as of July 2020

* Set up static IP for remote desktop host
* Set up router to port forward from WAN IP to server IP + port

## Automated WAN IP update to GoDaddy DNS via their REST API

```
# expects /root/.godaddy-dns.json to be written, e.g.:
#  {"domain": "example.com", "hostname": "server", "api_key": "XXX", "api_secret": "YYY"}

# scripts placed here shall be _extensionless_
sudo cp update_ip_godaddy_dns /etc/cron.daily/
```

## Install VNC server software

```
sudo apt update
sudo apt install tightvncserver
vncpasswd
```

## Set up script to cleanly start xfce4 under VNC session

```
mkdir -p ~/.vnc
cat <<EOF > ~/.vnc/xstartup
#!/bin/sh
xrdb $HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup
```

## Set up script to start VNC server - typically called via SSH

```
cat <<EOF > ~/start_vnc.sh
#!/bin/bash
# env used to bypass any existing sessions (e.g. system in graphical.target as default)
env \
  -u SESSION_MANAGER \
  -u DBUS_SESSION_BUS_ADDRESS \
  tightvncserver \
    -geometry 1600x900
EOF
chmod +x ~/start_vnc.sh
```

## Open host firewall 
```
sudo ufw allow from 0.0.0.0/0 to any port 5901
```
