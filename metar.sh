#!/bin/bash

#####################################################################$
# metar.sh
#####################################################################$

# === Variables === #
var='print' #-- Variable impression

# === Variables d'entrées === #
_oaci=LFPO      #-- Code oaci de l'aeroport

_print=false #-- Condition impression

#####################################################################$

# === paramètres entrées === #
if [[ $# -eq 1 ]]; then
       _oaci=$1

elif [[ $# -eq 2 ]]; then
       _oaci=$1
       _print=$2

fi

# === Téléchargement du fichier === #
wget -q -O /home/pi/metar/$_oaci'_API.xml' 'https://aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&format=xml&stationString='$_oaci'&hoursBeforeN$

# === Récupération des données === #
metars=$(sed -n 's,.*<raw_text>\(.*\)</raw_text>,\1,p' /home/pi/metar/$_oaci'_API.xml')

# === Affichage des données === #
sed -n 's,.*<raw_text>\(.*\)</raw_text>,\1,p' /home/pi/metar/$_oaci'_API.xml'

# === Inscription des données dans les fichiers === #
echo -e $metars>> /home/pi/metar/metar_historique.txt
echo -e $metars>> /home/pi/metar/metar_$_oaci.txt

# === Vérification des conditions
if [ $_print == $var ]
then

         # === Impression === #
         lp /home/pi/metar/metar_$_oaci.txt

fi

rm /home/pi/metar/metar_$_oaci'.txt'
rm /home/pi/metar/$_oaci'_API.xml'

exit 1
