#!/bin/bash

entry=$(zenity --forms --title="Add Friend" \
	--text="Enter information about your friend." \
	--separator=";" \
	--add-entry="Maidenhead" \
	--add-entry="Latitude" \
	--add-entry="Longitude")
	
if [ -z "$entry" ] ; then
  exit 0
fi
IFS=';' read -ra my_array <<< "$entry"
echo ${my_array[0]} > ~/loc.dat
echo ${my_array[1]} >> ~/loc.dat
echo ${my_array[2]} >> ~/loc.dat
cat ~/loc.dat
#for i in "${my_array[@]}"
#do
#    echo $i
#done
