For use with Ubuntu Server 16.04

```
apt-get update
apt-get upgrade
apt-get install dos2unix python-letsencrypt-apache apache2 libapache2-mod-jk

guac_hostname=remote.example.com
email=user@domain.com

# configure apache
#a2enmod ssl
systemctl enable apache2
systemctl restart apache2

echo "ServerName ${guac_hostname}" > /etc/apache2/conf-available/guac.conf
ln -sf /etc/apache2/conf-available/guac.conf /etc/apache2/conf-enabled/guac.conf

#
ufw allow in "Apache Secure"

# get a server cert from lets encrypt.
letsencrypt --email "${email}" --apache --agree-tos -d "${guac_hostname}"


# install guacamole
wget https://raw.githubusercontent.com/MysticRyuujin/guac-install/master/guac-install.sh
chmod +x guac-install.sh
dos2unix guac-install.sh
./guac-install.sh

# modify server.xml to listen for proxied requests - enable this line:
#<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
systemctl enable tomcat8
systemctl restart tomcat8

systemctl enable guacd
systemctl restart guacd

# manually add this to /etc/apache2/sites-enabled/000-default-le-ssl.conf
#JKMount /* ajp13_worker
systemctl restart apache2

# try it! https://$guac_hostname/guacamole
# log in as guacadmin/guacadmin , create a new admin account, then disable this builtin account.

# TODO: enforce client cert verification

```
