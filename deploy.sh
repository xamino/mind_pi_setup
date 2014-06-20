#!/bin/sh

echo "installing stuff"
sudo apt-get update
sudo apt-get install -qy iw tcpdump ifrename iceweasel hostapd matchbox nodm
echo "setup connection"
sudo cp iftab /etc/iftab
sudo cp interfaces /etc/network/interfaces
sudo cp ifplugd /etc/default/ifplugd
sudo cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo cp checkconnection /usr/bin/checkconnection
sudo cp checkconnectionstart /etc/init.d/checkconnectionstart
sudo cp wlan-monitor /etc/init.d/wlan-monitor
sudo cp hostapd.conf /etc/hostapd/hostapd.conf
sudo cp hostapd /etc/default/hostapd
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
sudo cp nodm /etc/default/nodm
sudo cp .xsession /home/pi/.xsession
sudo cp iceweasel.conf /home/pi/iceweasel.conf
#kiosk mode - r-kiosk plugin
sudo cp -r {4D498D0A-05AD-4fdb-97B5-8A0AABC1FC5B} /usr/lib/iceweasel/browser/extensions/{4D498D0A-05AD-4fdb-97B5-8A0AABC1FC5B}

# reboot
echo "reboot!"
sudo reboot
