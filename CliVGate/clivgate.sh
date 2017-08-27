#!/bin/bash

main (){

ifconfig | grep tun
 if [ $? -eq 0 ]; then
  IMG='changes-prevent'
  TXT='CONECTADO'
 else
  IMG='changes-allow'
  TXT='DESCONECTADO'
 fi

yad --form --image=$IMG --image-on-top --title='CliVGATE' \
    --text-align='center' --text="<big><b>$TXT</b></big>"\
    --button='Conectar':0 \
    --button='Desconetcar':1 \
    --window-icon="network-vpn-symbolic"
#    --text="<i>By Maik Alberto</i>"\
#    --image=network-wired-symbolic

case $? in

	0)
	 rm -f index.html 2> /dev/null
	 wget www.vpngate.net/api/iphone/
	 tail -n +3 index.html | cut -d "," -f15 | base64 -d > teste64 2> /dev/null
	 openvpn --config teste64 &
         sleep 10
	 main
	;;
	1)
	killall openvpn
esac
}
main
