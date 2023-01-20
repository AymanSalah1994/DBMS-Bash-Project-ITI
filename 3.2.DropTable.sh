#!/bin/bash

# get the Table Name 
# If Exist then Delete it and Its Meta Data 
#  Not? 
#  Then Tell the User there is No thing 
# Use Notifications 
read -p "Enter the Name of the Table you Want to Drop ->$ " tableToDrop
cd $databaseName
    if [[ -f $tableToDrop ]] 
		then
            rm $tableToDrop
            rm "+$tableToDrop+types"
            rm "+$tableToDrop+pk"
            rm "+$tableToDrop+colNames"
            cd .. 
            notify-send  --icon=$PWD/check.png   Table-DROPPED  
            # TODO Export DB Name and Get back to the Connect Menu again  
        else
            echo "ERROR , table Not Found"
            cd .. 
			notify-send  --icon=$PWD/cancel.png  Not-Found
	fi
