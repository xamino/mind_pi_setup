﻿#!/bin/sh

echo "Doing security stuff – remember to set a safe password!"
echo "                     --> passwd pi"
sleep 1;

# clear firewall
sudo iptables -F
# default drop
sudo iptables -P INPUT REJECT
# accept everything from uni-ulm.de
sudo iptables -A INPUT -s 134.60.0.0/16 -p tcp -j ACCEPT
sudo iptables -A INPUT -s 134.60.0.0/16 -p udp -j ACCEPT
sudo iptables -A INPUT -s 134.60.0.0/16 -p icmp -j ACCEPT
# IMPORTANT: allow connections from self-initiated contacts
sudo iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
# allow all output
sudo iptables -A OUTPUT -j ACCEPT
# save configuration for reboot
sudo bash -c 'iptables-save > /etc/network/iptables'

echo "Done configuring firewall"

echo "installing stuff"
sudo apt-get update
# iw, ifrename for static wlan interfaces
sudo apt-get install -qy iw tcpdump ifrename hostapd
echo "setup connection"
sudo cp iftab /etc/iftab
sudo cp interfaces /etc/network/interfaces
sudo cp ifplugd /etc/default/ifplugd
sudo cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
# script from unknown origins that should keep ip assignment alive
sudo cp checkconnection /usr/bin/checkconnection
sudo cp checkconnectionstart /etc/init.d/checkconnectionstart
# monitor stuff (currently not used)
sudo cp wlan-monitor /etc/init.d/wlan-monitor
sudo cp hostapd.conf /etc/hostapd/hostapd.conf
sudo cp hostapd /etc/default/hostapd

# must set executable for some of that stuff
echo "now update-rd.de"
sudo chmod +x /etc/init.d/wlan-monitor
sudo chmod +x /etc/init.d/checkconnectionstart
sudo chmod +x /etc/init.d/hostapd
#sudo update-rc.d wlan-monitor defaults
sudo update-rc.d -f wlan-monitor remove
sudo update-rc.d checkconnectionstart defaults

#echo "setup display overscan"
sudo cp config.txt /boot/config.txt

echo "setup touch input"
sudo cp modules /etc/modules

#copy link
#echo "install link"
#sudo cp MIND.html /home/pi/Desktop/MIND.html

#kiosk mode
echo "init kiosk mode"
sudo apt-get install iceweasel matchbox nodm
sudo cp nodm /etc/default/nodm
# also disables screensaver (try 4) --> works!
sudo cp xsession /home/pi/.xsession
sudo cp iceweasel.conf /home/pi/iceweasel.conf
#kiosk mode - r-kiosk plugin
sudo cp -r {4D498D0A-05AD-4fdb-97B5-8A0AABC1FC5B} /usr/lib/iceweasel/browser/extensions/{4D498D0A-05AD-4fdb-97B5-8A0AABC1FC5B}
#raspi-config procedure
#set to console-boot
sudo update-rc.d lightdm disable 2
#remove boottoscratch (if exists)
sudo rm -f /etc/profile.d/boottoscratch.sh
# disable screensaver (try 1) (didn't work)
sudo cp autostart /etc/xdg/lxsession/LXDE/autostart
# disable screensaver (try 2) (didn't work)
sudo cp xinitrc /etc/X11/xinit/xinitrc
# disable screensaver (try 3) (works, but only for terminal, not x server)
sudo cp config /etc/kbd/config

#set time settings and cronjob
echo "Setting time and cron job"
sudo cp timezone /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata
sudo cp pi /var/spool/cron/crontabs/pi

# reboot
echo "reboot!"
sudo reboot
