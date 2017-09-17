#!/bin/bash

#Generer un nombre aleatoire pour Securité contre robots
in=100
max=200
number=$[($RANDOM % ($[200 - 100] + 1)) + 100]
echo $number

#On crée le formulaire en stockant les valeurs de sortie dans $cfgpass :/
cfgpass=`zenity --forms \
    --title="Server ToolBox" \
    --text="Veuillez saisir le mot de pass root" \
    --add-entry="Nom de l'utilisateur" \
    --add-password="Password root" \
    --add-password="Confirmer le password" \
    --add-entry="Confirmer que vous n'etes pas robot reécrire ce chiffre($number)" \
    --separator="|"`




#Si on clique sur le bouton Annuler
if [ "$?" -eq 1 ]; then
    zenity --info --text "
	<b><span color=\"green\" font-family=\"Arial\">Merci pour votre essai</span></b>"
    exit
fi
testious=$(echo "$cfgpass" | cut -d "|" -f4)
if [ "$number" != "$testious" ] ; then
zenity --info --text "
	<b><span color=\"red\" font-family=\"Arial\">Code de confirmation incorrect, Merci pour votre essai</span></b>"
	bash script.sh
	exit
fi
#Sinon on continue


	#On peut récupérer les valeurs des différents champs de cette façon :
	echo "$cfgpass" | cut -d "|" -f1 #Nom de l'utilisateur
	echo "$cfgpass" | cut -d "|" -f2 | md5sum #Ancien Mot de passe
	echo "$cfgpass" | cut -d "|" -f3 | md5sum #Nouveau Mot de passe
	echo "$cfgpass" | cut -d "|" -f4 | md5sum #Confirmation du nouveau mot de passe
passwd=$(echo "$cfgpass" | cut -d "|" -f2)
echo $passwd | sudo -S su
if [ "$?" -eq 1 ]; then
zenity --error --text "
	<b><span color=\"red\" font-family=\"Arial\">Password Invalide</span></b>"
	bash main.sh
	
fi
if [ "$?" -eq 0 ]; then
zenity --info --text "
	<b><span color=\"green\" font-family=\"Arial\">Password Valide , Welcome again</span></b>"
	if [ "$?" -eq 0 ]; then
		if ret=`zenity --entry --title="Jour" --text="Veuillez Le service " Server-notification-mail My-Ip Watch-server-Performance 
`
		then
			titre=$ret
			if [ "$titre" = "Watch-server-Performance" ]
				then
					bash ServerPerformance.sh
					
			fi
			if [ "$titre" = "My-Ip" ]
				then
				bash MyIp.sh			
			fi
			if [ "$titre" = "Server-notification-mail" ]
				then
				bash ServerMailing.sh			
			fi
		else
			echo "Tsss, un titre on dit, pas le bouton annuler!"
			exit
			fi
		echo $titre
	fi	
exit
fi




