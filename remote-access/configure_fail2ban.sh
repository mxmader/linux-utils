#!/usr/bin/env bash

set -e

sudo apt-get install -y fail2ban crudini
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# only give clients one try at authentication. only true way to keep the bad guys out.
sudo crudini --set /etc/fail2ban/jail.local DEFAULT bantime -1
sudo crudini --set /etc/fail2ban/jail.local DEFAULT maxretry 1
sudo systemctl restart fail2ban

# to unban a given IP if you make a mistake during this procedure, run this via console:
# fail2ban-client set sshd unbanip <client IP>

# Set basic firewall rule(s)
ufw allow ssh
ufw enable
