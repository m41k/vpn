#/bin/bash
/etc/init.d/tinyproxy start
/etc/init.d/tinyproxy start
cd /opt/starget/
openvpn --config client2.ovpn --auth-user-pass us --route-noexec &
route add 186.202.176.102 dev tun0
