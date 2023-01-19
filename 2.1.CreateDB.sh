#!/bin/bash

read  -p "Enter the Name of the DataBase You want to Create ->" databaseName
if [[ $databaseName =~ ^[a-zA-Z0-9_]+$ ]] 
# We need the + Sign So Not an Empty string
        then 
        echo "Valid" ; 
        # Search for it And Either Create Or Reject 
        if [[ -d $databaseName ]] 
			then
		echo "The Database Exists , Please Choose another Name " ; 
        else
			mkdir $databaseName
			echo "DataBase is Created" ;
			notify-send  --icon=$PWD/check.png  $databaseName created
			# $man notify-send 
			# TODO connect to the New DB Directly 
		fi
else 
echo "Not Valid Name , only Letters , numbers and Underscores" ;
notify-send  --icon=$PWD/cancel.png  ERROR
fi 

