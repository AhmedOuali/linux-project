#!/bin/bash
 
MonIpPublic=$(dig +short myip.opendns.com @resolver1.opendns.com)
MonIpLocal=$(host $HOSTNAME | awk '{print $NF}' | head -n 1)

zenity --info --title="Server ToolBox (Ip Informations)"  --text "
<span color=\"green\">Adresse Public: <b>$MonIpPublic</b></span>
<span color=\"green\">Adresse Local : <b>$MonIpLocal</b></span>"
if [ "$?" -eq 0 ]; then
	zenity --info --text "
	<b><span color=\"green\" font-family=\"Arial\">Mail De Backup est configuré avec succées</span></b>"
	if [ "$?" -eq 0 ]; then
		bash main.sh
	fi

fi





