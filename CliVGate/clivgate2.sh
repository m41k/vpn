#!/bin/bash

DEV='tun41'

off(){
	yad --width=200 --title="CliVGATE" \
	 --window-icon='network-vpn' \
	 --button='Desconectar':0
	   if [ $? -eq 0 ]; then
	      killall openvpn &
	      killall $0
	   fi
	}

tray(){
	yad --notification  \
        --image=network-vpn \
        --text "CliVGATE" \
        --command=$0
}

ifconfig | grep tun
 if [ $? -eq 0 ]; then
  off
 fi

case $1 in
	off)off
	;;
	tray)tray
	;;
	on)

#==>[CONECT]
lista=( `cut -d "," -f2,7  index.html | while read LINHA; do echo "$LINHA"; done`)
# --item-separator="." \
# --image='network-vpn' \

action=$(yad --entry --width=200 --title="CliVGATE" \
 --window-icon='network-vpn' \
 --text="<b>Select a server:</b>" \
 --entry-text \
 ${lista[@]}  \
 --button='Conectar':0 )
server=( `echo $action | cut -d"," -f1` )

cat index.html | grep $server | cut -d"," -f15 | base64 -d > teste64 2> /dev/null

openvpn --config teste64 &
#openvpn --config teste64 --script-security 2 --up "$0 tray" &
#sleep 10

#######
tray

;;
esac
