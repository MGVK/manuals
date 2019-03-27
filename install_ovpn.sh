#!/bin/bash

sudo apt install -y liblzo2-dev libpam0g-dev unzip

wget https://swupdate.openvpn.org/community/releases/openvpn-2.4.7.zip

unzip openvpn-2.4.7.zip

cd openvpn-2.4.7/

 ./configure && sudo make && sudo make install 

printf "[Unit]
Description=OpenVPN service
After=network.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/true
ExecReload=/bin/true
WorkingDirectory=/etc/openvpn

[Install]
WantedBy=multi-user.target" > openvpn.service

printf "[Unit]
Description=OpenVPN connection to %i
PartOf=openvpn.service
ReloadPropagatedFrom=openvpn.service
Before=systemd-user-sessions.service
Documentation=man:openvpn(8)
Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO

[Service]
PrivateTmp=true
KillMode=mixed
Type=forking
ExecStartPre= /bin/bash -c 'if [ ! -d /run/openvpn ]; then  mkdir /run/openvpn; fi'
ExecStart=/usr/local/sbin/openvpn --daemon ovpn-%i --status /run/openvpn/%i.status 10 --cd /etc/openvpn --script-security 2 --config /etc/openvpn/%i.conf --writepid /run/openvpn/%i.pid
PIDFile=/run/openvpn/%i.pid
ExecReload=/bin/kill -HUP $MAINPID
WorkingDirectory=/etc/openvpn
ProtectSystem=yes
CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH CAP_AUDIT_WRITE
LimitNPROC=10
DeviceAllow=/dev/null rw
DeviceAllow=/dev/net/tun rw

[Install]
WantedBy=multi-user.target " > openvpn@.service

#uncomment this if you want to work with systemctl

sudo cp openvpn.service /lib/systemd/system/openvpn.service
sudo cp openvpn.service /lib/systemd/system/openvpn@.service

