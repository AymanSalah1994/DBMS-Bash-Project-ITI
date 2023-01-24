#!/bin/bash
echo "Counting DataBases : "
wc -l DataBases 
read  -p "TO DROP : Enter the Name of the DataBase ->" databaseName
if [[ -d $databaseName ]] 
                then
            rm -r $databaseName
            ls -F  | grep "/" > DataBases
            notify-send  --icon=$PWD/check.png  $databaseName DELETED 
            else
                notify-send  --icon=$PWD/cancel.png  NOT FOUND 
                echo "Available Databases " 
                ./2.2.ListDatabases.sh
            fi
