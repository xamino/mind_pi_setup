#!/bin/sh

echo "installing stuff"
sudo apt-get update
sudo apt-get install -qy iw tcpdump ifrename iceweasel matchbox-keyboard
echo "setup connection"
sudo cp iftab /etc/iftab
sudo cp interfaces /etc/network/interfaces
sudo cp ifplugd /etc/default/ifplugd
sudo cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo cp checkconnection /usr/bin/checkconnection
sudo cp checkconnectionstart /etc/init.d/checkconnectionstart
sudo cp wlan-monitor /etc/init.d/wlan-monitor
echo "now update-rd.de"
sudo chmod +x /etc/init.d/wlan-monitor
sudo chmod +x /etc/init.d/checkconnectionstart
sudo update-rc.d wlan-monitor defaults
sudo update-rc.d checkconnectionstart defaults

#echo "setup display overscan"
sudo cp config.txt /boot/config.txt

echo "setup touch input"
sudo cp modules /etc/modules
sudo cp keyboard.sh /home/pi/Desktop/keyboard.sh

#copy link
echo "install link"
sudo cp MIND.html /home/pi/Desktop/MIND.html

# reboot
echo "reboot!"
sudo reboot
