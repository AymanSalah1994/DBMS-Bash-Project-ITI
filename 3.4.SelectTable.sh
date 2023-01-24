#!/bin/bash

read -p "Enter the Table you Want to Select From ->" tableToSelect
cd $databaseName
if [[ -f $tableToSelect ]]
then 
    lengthStringToArray=`wc +$tableToSelect+colNames -w`
    totalColumns=($lengthStringToArray) # Total nubmer of Columns 
    namesLine=`cat +$tableToSelect+colNames`
    ArrayOfColNames=($namesLine)  # Columns Names to Show to the User 
    echo  "Available Columns: $namesLine"
else 
    cd ..
    notify-send  --icon=$PWD/cancel.png  "No Such a Table !"
    ./3.Connect.sh 
fi

read -p "Enter the Nubmer of Columns you Want to Select ->" noOfColumns 

if [ $noOfColumns -lt 1 -o  $noOfColumns -gt $totalColumns ]
then 
cd .. 
notify-send  --icon=$PWD/cancel.png  "Invalid Number"
./3.Connect.sh
fi 

if [ $noOfColumns -eq $totalColumns ]
then 
echo "ALL Columns will be Selected "
    while read line
    do 
    echo $line
    done < $tableToSelect
    read -p "Press Enter To Continue : " option
    case $REPLY in
        *) 
        cd .. 
        ./3.Connect.sh
        ;;
    esac
fi 

if [ $noOfColumns -lt $totalColumns  ]
then 
    echo "SOME Columns will be Selected "
    echo  "Available Columns: $namesLine"
    # selectedIndexes
    typeset -i counter
    typeset -i index
    counter=1
    index=0
    while [ $index -ne $noOfColumns ]
    do
        read  -p  "${counter} -Enter Column Index For Selection -$ " userInput
        if [[ $userInput =~ ^[a-zA-Z_]+$ ]] 
        then 
            echo "Numbers Only"
            continue
        fi

        if [ $userInput -lt 1 -o  $userInput -gt $totalColumns ]
        then
            echo "Invalid Index"
            continue
        fi

        Arr[$index]=$userInput-1
        ((index = index + 1))
        ((counter = counter + 1))
    done

    while read line
    do
    ArrayOfColValues=($line)
            for i in ${Arr[*]}
            do
            echo -en  ${ArrayOfColValues[i]} '\t'
            done
    echo
    done < $tableToSelect
    read -p "Press Enter To Continue : " option
    case $REPLY in
        *) 
        cd .. 
        ./3.Connect.sh
        ;;
    esac
fi 
