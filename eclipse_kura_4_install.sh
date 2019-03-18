#!/bin/bash

#install dependencies
sudo apt install isc-dhcp-server dos2unix bind9 ethtool telnet bluez-hcidump hostapd unzip iw wireless-tools


cd /tmp
wget http://ftp.fau.de/eclipse/kura/releases/4.0.0/kura_4.0.0_raspberry-pi-2-3_installer.deb
dpkg -i kura_4.0.0_raspberry-pi-2-3_installer.deb

