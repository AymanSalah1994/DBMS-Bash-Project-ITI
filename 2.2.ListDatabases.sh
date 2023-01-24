#!/usr/bin/bash

clear
ls -F  | grep "/" > DataBases
wc -l DataBases
echo  "     *---------Databases with Their Tables-------------*   "  
for eachDB in `cat DataBases`
do
echo "Database Name: "
echo $eachDB 
echo "          ====End Of DataBase====         "
done
./1.Entry.sh
