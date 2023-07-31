#!/usr/bin/env bash

set -e

export SSH_PORT=6666

sudo ufw enable

sudo apt-get install -y fail2ban crudini openssh-server
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Set basic firewall rule(s)
# disabled - uses port 22
# sudo ufw allow ssh
sudo ufw allow from any proto tcp to any port "${SSH_PORT}"

# only give clients one try at authentication. only true way to keep the bad guys out.
sudo crudini --set /etc/fail2ban/jail.local DEFAULT bantime -1
sudo crudini --set /etc/fail2ban/jail.local DEFAULT maxretry 1
sudo systemctl restart fail2ban

# configure SSH server options + security by obscurity
sudo sed -i -e "s/^#*Port.*$/Port ${SSH_PORT}/" /etc/ssh/sshd_config
sudo sed -i -e "s/^#*PermitRootLogin.*$/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i -e "s/^#*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo systemctl restart ssh

# to unban a given IP if you make a mistake during this procedure, run this via console:
# fail2ban-client set sshd unbanip <client IP>
