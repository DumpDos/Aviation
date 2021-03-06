#!/bin/bash

#####################################################################$
# metar.sh
# DumpDos
#####################################################################$

# === Variables === #
var='print'     #-- Variable impression
varmet='metar'  #-- Variable metar
vartaf='taf'  #-- variable notam

# === Variables d'entrées === #
_oaci=LFPO   #-- Code oaci de l'aeroport
_print=false #-- Condition impression

#####################################################################$

# === paramètres entrées === #
if [[ $# -eq 1 ]]; then
       _data=$1
       _oaci=$2

elif [[ $# -eq 2 ]]; then
       _data=$1
       _oaci=$2
       _print=$3

fi

# === Vérification des conditions === #
if [ $_data == $varmet ]
then

# === Téléchargement du fichier === #
wget -q -O /home/pi/metar/$_oaci'_metAPI.xml' 'https://aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&format=xml&stationString='$_oaci'&hoursBeforeNow=0.1'

# === Récupération des données === #
metars=$(sed -n 's,.*<raw_text>\(.*\)</raw_text>,\1,p' /home/pi/metar/$_oaci'_metAPI.xml')

# === Affichage des données === #
sed -n 's,.*<raw_text>\(.*\)</raw_text>,\1,p' /home/pi/metar/$_oaci'_metAPI.xml'

# === Inscription des données dans les fichiers === #
echo -e $metars>> /home/pi/metar/metar_historique.txt
echo -e $metars>> /home/pi/metar/metar_$_oaci.txt

elif [ $_data == $vartaf ]
then

# === Téléchargement du fichier === #
wget -q -O /home/pi/metar/$_oaci'_tafAPI.xml' 'https://aviationweather.gov/adds/dataserver_current/httpparam?dataSource=tafs&requestType=retrieve&format=xml&stationString='$_oaci'&hoursBeforeNow=0.1'

# === Récupération des données === #
taf=$(sed -n 's,.*<raw_text>\(.*\)</raw_text>,\1,p' /home/pi/metar/$_oaci'_tafAPI.xml')

# === Affichage des données === #
sed -n 's,.*<raw_text>\(.*\)</raw_text>,\1,p' /home/pi/metar/$_oaci'_tafAPI.xml'

# === Inscription des données dans les fichiers === #
echo -e $tafs>> /home/pi/metar/tafs_historique.txt
echo -e $tafs>> /home/pi/metar/taf_$_oaci.txt

fi

# === Vérification des conditions === #
if [ $_print == $var ]
then

         # === Impression === #
         lp /home/pi/metar/metar_$_oaci.txt

fi

rm /home/pi/metar/metar_$_oaci'.txt'
rm /home/pi/metar/$_oaci'_API.xml'

exit 1
