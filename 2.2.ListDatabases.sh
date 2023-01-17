#!/usr/bin/bash

# NOTE: Since a Database = Directory ,,, Any Directory Means a DB ! 
echo `clear`
echo `ls -F  | grep "/" > dbnames` 
echo `wc -l dbnames` 
# echo `awk '{print($0)}' newLine` ; 
echo `sed "p" newLine` 
echo "*---------Databases with Their Tables-------------*" 
echo "*---------Databases with Their Tables-------------*"
for eachTable in `cat dbnames`
do
echo
echo $eachTable 
ls $eachTable
echo "====End Of DataBase===="
done
