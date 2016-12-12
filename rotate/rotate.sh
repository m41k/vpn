#!/bin/bash

#Script altera a rota após quantidade de pacote deteminado.
#Trabalhando com 3 interfaces tun

#endereco a ser acessado
end=153.121.72.211

#interface tun atual da rota
ntun=`route -n | grep $end | rev | cut -d " " -f 1 | rev | sed 's/tun//g'`
#ntun=0

#Quantidade de pacote para alterar saida
pac=13

#echo $tun
while [ $ntun -lt 3 ];
 do
#       echo tun$ntun
        tcpdump -i tun$ntun -c $pac &> /dev/null
        route del $end
        if [ $ntun -eq 2 ]; then
          ntun=0
        else
          ntun=`expr $ntun + 1`
       fi
        route add $end dev tun$ntun
#sleep 5
 done
