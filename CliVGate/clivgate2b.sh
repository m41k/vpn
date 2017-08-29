#!/bin/bash

#	--percentage=82 \
#	--image=edit-find \
on(){
	rm -f servers 2> /dev/null
#	wget www.vpngate.net/api/iphone/ | \
#	curl -o down www.vpngate.net/api/iphone/ | \
#yad --title="Teste" --progress --progress-text="Buscando servidores" --pulsate --auto-close --auto-kill
	wget www.vpngate.net/api/iphone/ -O servers 2>&1 | 
	yad --progress \
	--title="CliVGate" \
	--width="200" \
	--window-icon='network-vpn' \
	--image=edit-find-symbolic \
	--text="<b>Buscando servidores...</b>" \
	--progress-text="Aguarde" \
	--no-buttons \
	--pulsate \
	--auto-close \
	--auto-kill

#	lista=( `tail -n +3 index.html | cut -d "," -f15 | base64 -d > teste64 2> /dev/null `)
#	lista=( `cut -d "," -f2,7  index.html | while read LINHA; do echo "$LINHA"; done`)
	lista=( `tail -n +3 servers | cut -s -d "," -f2,7 | while read LINHA; do echo "$LINHA"; done `)

	action=$(yad --entry --width=200 --title="CliVGATE" \
	 --window-icon='network-vpn' \
	 --text="<b>Select a server:</b>" \
	 --entry-text \
	 ${lista[@]}  \
	 --button='Conectar':0 )
	server=( `echo $action | cut -d"," -f1` )

	cat servers | grep $server | cut -d"," -f15 | base64 -d > teste64 2> /dev/null

	openvpn --config teste64 &
	#openvpn --config teste64 --script-security 2 --up "$0 tray" &
	#sleep 10
	#######
	tray
	}

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
	on)on
	;;
esac
