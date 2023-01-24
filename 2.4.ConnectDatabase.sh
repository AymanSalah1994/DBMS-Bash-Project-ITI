#!/bin/bash

echo "Counting DataBases : "
wc -l DataBases 
read  -p "TO CONNECT : Enter the Name of the DataBase ->" databaseName
if [[ -d $databaseName ]] 
                then
                    notify-send  --icon=$PWD/check.png  $databaseName CONNECTED
                    export databaseName
                    ./3.Connect.sh
            else
                notify-send  --icon=$PWD/cancel.png  NOT FOUND 
                echo "Available Databases " 
                ./2.2.ListDatabases.sh
fi
