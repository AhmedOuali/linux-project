#!/bin/bash
# 
#
#



cfgmail=`zenity --forms \
    --title="Server ToolBox (Mail backup) " \
    --text="Veuillez saisir les informations nécessaire" \
    --add-entry="Adresse Destination" \
    --add-entry="Sujet du mail" \
    --separator="|"`
if [ "$?" -eq 0 ]; then
	MailTo=$(echo "$cfgmail" | cut -d "|" -f1)
	Subject=$(echo "$cfgmail" | cut -d "|" -f2)
	 
	 
	#On va chercher tous les fichiers PHP qui ont été modifié ce jour
	find /var/www/ -name -prune -o -regex '.*\.\(php\|html\|js\).*' -mtime 0 > ListeFichierModifier.txt
	 
	mail -s "$Subject" "$MailTo" < ListeFichierModifier.txt

	rm ListeFichierModifier.txt

	zenity --info --text "
	<b><span color=\"green\" font-family=\"Arial\">Mail De Backup est configuré avec succées</span></b>"
	bash main.sh
else
	 zenity --info --text "
	<b><span color=\"green\" font-family=\"Arial\">Merci pour votre essai</span></b>"
	bash main.sh
    	exit
fi


