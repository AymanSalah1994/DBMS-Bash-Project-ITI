#!/bin/bash
clear
read  -p "Enter the Name of the DataBase You want to Create ->" databaseName
if [[ $databaseName =~ ^[a-zA-Z0-9_]+$ ]] 
        then 
        if [[ -d $databaseName ]] 
			then
		notify-send  --icon=$PWD/cancel.png  "ERROR The Database Exists  , Please Choose another Name"
		./2.1.CreateDB.sh
			else
				mkdir $databaseName
				echo "DataBase is Created" ;
				notify-send  --icon=$PWD/check.png  $databaseName created
				export databaseName
				./3.Connect.sh
		fi
else
echo "" ;
notify-send  --icon=$PWD/cancel.png  "ERROR Not Valid Name , only Letters , numbers and Underscores"
./2.1.CreateDB.sh
fi 

