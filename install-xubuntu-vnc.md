For use with Xubuntu 16.04 to 17.10


```
sudo apt-get update && apt-get upgrade && reboot
sudo apt-get install tightvncserver
vncpasswd
# enter password 2x

# script to cleanly start xfce4 under VNC session
cat <<EOF > ~/.vnc/xstartup
#!/bin/sh
xrdb $HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# script to start VNC server - typically called via SSH
cat <<EOF > start_vnc.sh
#!/bin/bash
# env used to bypass any existing sessions (e.g. system in graphical.target as default)
env -u SESSION_MANAGER -u DBUS_SESSION_BUS_ADDRESS tightvncserver -geometry 1600x900
EOF
chmod +x start_vnc.sh

# open firewall
sudo ufw allow from 0.0.0.0/0 to any port 5901
```
