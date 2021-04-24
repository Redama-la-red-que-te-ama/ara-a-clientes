#!/bin/ksh

baseurl="https://guiaempresas.universia.es/localidad"
typeset -a conact
typeset -i pages
village=
while [ -z $village ]; do
	echo -n "Type the name of the village: "
	read village
	typeset -u village=$(echo $village | sed 's/ /-/g')
done
province=
while [ -z $province ]; do
	echo -n "Type the name of the province: "
	read province
	typeset -u province=$(echo $province | sed 's/ /-/g')
done

baseurl="$baseurl/$village-$province/"
echo $baseurl
lynx -dump -listonly "$baseurl" | sed -n "/Visible links:/,/Hidden links:/{p;/Hidden links:/q}" | sed -e :a -e '$d;N;2,2ba' -e 'P;D' \
	| grep "guiaempresas" | grep -v "servlet" | grep . | grep -v "localidad" | grep -v provincia
echo  "########"
lynx -dump -listonly "$baseurl" | sed -n "/Visible links:/,/Hidden links:/{p;/Hidden links:/q}" | sed -e :a -e '$d;N;2,2ba' -e 'P;D' | grep "qPagina"
