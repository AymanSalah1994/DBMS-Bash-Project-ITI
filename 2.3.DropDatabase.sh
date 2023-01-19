#!/bin/bash

# Ask For a Dabases to Drop 
# Search For it 
#  If exists , Delete and Update Databases File 
#  Else , List All Available Databases 
# 



read  -p "TO DROP : Enter the Name of the DataBase ->" databaseName
if [[ $databaseName =~ ^[a-zA-Z0-9_]+$ ]] 
        then
            if [[ -d $databaseName ]] 
                then
            rm -r $databaseName
            ls -F  | grep "/" > DataBases
            notify-send  --icon=$PWD/check.png  $databaseName DELETED 
            else
                notify-send  --icon=$PWD/cancel.png  NOT FOUND 
                echo "Available Databases " 
                # List Databases and Prompt for Deletion again
                ./2.2.ListDatabases.sh
                ./2.3.DropDatabase.sh
            fi
else 
echo "Not Valid DataBase Name To search" ;
notify-send  --icon=$PWD/cancel.png  ERROR
./2.3.DropDatabase.sh
# Call itself again 
fi 

