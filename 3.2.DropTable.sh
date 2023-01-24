#!/bin/bash

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
            ./3.Connect.sh
        else
            echo "ERROR , table Not Found"
            cd .. 
			notify-send  --icon=$PWD/cancel.png  Not-Found
            ./3.Connect.sh
	fi
