#!/usr/bin/bash

# NOTE: Since a Database = Directory ,,, Any Directory Means a DB ! 
# We will Not make any other Directory for anything else inside the project folder
clear
ls -F  | grep "/" > DataBases
wc -l DataBases
# echo `awk '{print($0)}' newLine` ; 

echo "*---------Databases with Their Tables-------------*"
for eachDB in `cat DataBases`
do
echo "Database Name: "
echo $eachDB 
echo "Tables : "
ls $eachDB
echo "====End Of DataBase===="
done
# TODO Enter Ok to contiune Or q To Quit

