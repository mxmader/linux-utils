sudo yum install -y epel-release
sudo yum groupinstall "X Window System" xfce
sudo yum install -y xorg-x11-fonts*
sudo systemctl set-default graphical.target
sudo systemctl isolate graphical.target

sudo yum install -y tightvnc-server

cat <<EOF > ~/.vnc/xstartup
#!/bin/sh

xrdb $HOME/.Xresources
startxfce4 &
EOF

chmod +x ~/.vnc/xstartup
vncserver -geometry 1600x900

# enter password 2x