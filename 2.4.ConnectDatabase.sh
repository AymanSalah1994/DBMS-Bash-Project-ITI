#!/bin/bash

# Connection is Very Similar to Drop Logic , But with some tweaks
echo "Counting DataBases : "
wc -l DataBases 
read  -p "TO CONNECT : Enter the Name of the DataBase ->" databaseName
if [[ $databaseName =~ ^[a-zA-Z0-9_]+$ ]] 
        then
            if [[ -d $databaseName ]] 
                then
                    notify-send  --icon=$PWD/check.png  $databaseName CONNECTED
                    export databaseName
                    # If we Use $ sign it will not be sent there
                    ./3.Connect.sh
            else
                notify-send  --icon=$PWD/cancel.png  NOT FOUND 
                echo "Available Databases " 
                # List Databases and Prompt for Deletion again
                ./2.2.ListDatabases.sh
                ./2.4.ConnectDatabase.sh
            fi
else 
echo "Not Valid DataBase Name To search" ;
notify-send  --icon=$PWD/cancel.png  ERROR
./2.4.ConnectDatabase.sh
# Call itself again 
fi 
