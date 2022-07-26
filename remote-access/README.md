# Xubuntu remote access

All procedures aimed at Xubuntu 22.04 as of July 2022

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

## Set up system services
```
mkdir -p /usr/lib/systemd/system/
sudo cp joe-vnc.service /usr/lib/systemd/system/joe-vnc@:1.service
sudo systemctl daemon-reload
sudo systemctl enable joe-vnc@:1
sudo systemctl start joe-vnc@:1
```

## Open host firewall 
```
sudo ufw allow from 0.0.0.0/0 to any port 5901
```
