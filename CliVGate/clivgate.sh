#!/bin/bash
#Client for VPNGate
#Created by:Maik Alberto - github.com/m41k
main (){

ifconfig | grep tun
 if [ $? -eq 0 ]; then
  IMG='changes-prevent'
  TXT='CONECTADO'
#  BTN='Desonectar'
#  ACT='1'
  BTN='Desconetcar:1'
 else
  IMG='changes-allow'
  TXT='DESCONECTADO'
#  BTN='Conectar'
#  ACT='0'
  BTN='Conetcar:0'
 fi

yad --form --image=$IMG --image-on-top --title='CliVGATE' \
    --text-align='center' --text="<big><b>$TXT</b></big>"\
    --window-icon="network-vpn-symbolic" \
    --button=$BTN
#    --button="$BTN":$ACT
#    --button='Conectar':0 \
#    --button='Desconetcar':1 \
#    --text="<i>By Maik Alberto</i>"\
#    --image=network-wired-symbolic

case $? in

	0)
	 rm -f index.html 2> /dev/null
	 wget www.vpngate.net/api/iphone/
	 tail -n +3 index.html | cut -d "," -f15 | base64 -d > teste64 2> /dev/null
	 openvpn --config teste64 &
         sleep 10
 	 yad --notification  \
         --image=network-vpn \
	 --text "CliVGATE" \
	 --command=./$0
#	 main
	;;
	1)
	killall openvpn &
esac
}
main
