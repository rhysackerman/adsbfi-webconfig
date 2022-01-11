#!/bin/bash

if [ $(id -u) -ne 0 ]; then
  echo -e "This script must be run as root. \n"
  exit 1
fi


sudo apt install php7.3 php7.3-fpm php7.3-cgi
sudo lighttpd-enable-mod fastcgi-php
sudo service lighttpd force-reload


mkdir /home/pi/adsbexchange/webconfig
cp -t /home/pi/adsbexchange/webconfig adsb-config.txt.webtemplate install-adsbconfig.sh install-wpasupp.sh webconfig.sh
cp ./webconfig.service /etc/systemd/system/
cp ./010_www-data /etc/sudoers.d/
rm /var/www/html/index.htm
cp ./html/* /var/www/html
cp ./dnsmasq.conf /etc/
cp ./wpa_supplicant.conf.bak /boot/wpa_supplicant.conf.bak
cp ./wpa_supplicant.conf.bak /boot/wpa_supplicant.conf
cp ./wpa_supplicant.conf.bak /home/pi/adsbexchange/.adsbx/wpa_supplicant.conf
cp ./adsb-config.txt.initial /home/pi/adsbexchange/.adsbx/adsb-config.txt
cp ./adsb-config.txt.initial /boot/adsb-config.txt




systemctl daemon-reload
systemctl enable webconfig
