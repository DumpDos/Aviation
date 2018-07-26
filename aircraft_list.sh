#!/bin/bash
#=== Dumpdos 2018 ===#

#--- Variables ---#
VRS_ip='192.168.xxx.xxx'

################
#--- Script ---#
################


wget -O AircraftList.json http://$VRS_ip/VirtualRadar/AircraftList.json

tota_ac=$(jq '.totalAc' AircraftList.json)

regi_ac=$(jq '.acList[0].Reg' AircraftList.json)
type_ac=$(jq '.acList[0].Type' AircraftList.json)

echo $total_ac
echo "Aircraft :"$regi_ac $type_ac
