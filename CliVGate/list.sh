#!/bin/bash

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

#######

#itens=$(echo "teste1 teste2 teste3")


#echo $action

# $itens


itens=$(echo "teste1.teste2.teste3")

#yad --list \
# --colum='OP':NUM --colum='Opcoes':TEXT \
# 1 'Teste1' \
# 2 'teste2' \
# 3 'teste3'

# --item-separator="," \

#lista=( `cat lista.txt | while read LINHA; do echo "$LINHA"; done`)
#echo ${lista[@]}

#yad --form --title="teste" \
# --field="Server:CB" \
# --item-separator=" " \
#  "$(echo ${lista[@]})"

# 'teste1.teste2.teste3!
