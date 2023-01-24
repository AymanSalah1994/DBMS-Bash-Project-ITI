#!/bin/bash

read -p "Enter the Table you Want to DELETE From ->" tableToDelete

cd $databaseName
if [[ -f $tableToDelete ]]
then 
    lengthStringToArray=`wc +$tableToDelete+colNames -w`
    totalColumns=($lengthStringToArray) # Total nubmer of Columns 
    namesLine=`cat +$tableToDelete+colNames`
    ArrayOfColNames=($namesLine)  # Columns Names to Show to the User 
    echo  "Available Columns: $namesLine"
    typesLine=`cat +$tableToDelete+types`
    ArrayOfTypes=($typesLine) 
else 
    cd ..
    notify-send  --icon=$PWD/cancel.png  "No Such a Table !"
    ./3.Connect.sh 
fi

# typeset -i indexOfCondition
while true
    do
        read -p "Enter the Index of Column You Choose as a Condition ->" indexOfCondition
        if [[ $indexOfCondition =~ ^[a-zA-Z]+$ ]] 
        then 
            echo "Numbers Only"
            continue
        fi
        if [ $indexOfCondition -lt 1 -o  $indexOfCondition -gt $totalColumns ]
        then
            echo "Invalid Index"
            continue
        else 
            break  # This Means Number is Valid 
        fi
    done

 # To get REAL index 
let indexOfCondition=indexOfCondition-1
theValueType=${ArrayOfTypes[$indexOfCondition]} # Str or Int 
echo "The Value Type For selection"
echo $theValueType
echo "The Final Index "
echo $indexOfCondition
while true
    do
        read -p "Enter the Value of Column Test Against ->" valueOfCondition
        if [ $theValueType = "int" ]
        then
            if [[ $valueOfCondition =~ ^[0-9]+$ ]] 
            then 
            break
            else  
            echo " Not a Valid Type INT"
            continue
            fi
        fi

        if [ $theValueType = "str" ] 
        then 
            if [[ $valueOfCondition =~ ^[a-zA-Z]+$ ]] 
            then 
            break
            else  
            echo " Not a Valid Type STR "
            continue
            fi
        fi
    done

echo $indexOfCondition
echo $valueOfCondition

        if [ $theValueType = "int" ]
        then
            while read line
            do 
            ArrayOfColValues2=($line)
                if [ ${ArrayOfColValues2[$indexOfCondition]} -eq $valueOfCondition  ]
                then 
                    echo "DELETED : "
                    echo $line
                else 
                    `echo $line >> temporayFileAfterDeletion`
                fi
            done < $tableToDelete
            `cat temporayFileAfterDeletion > $tableToDelete`
            `rm temporayFileAfterDeletion `
            cd .. 
            ./3.Connect.sh
            fi

        if [ $theValueType = "str" ] 
        then 
            while read line
            do 
            ArrayOfColValues2=($line)
                if [ ${ArrayOfColValues2[$indexOfCondition]} = $valueOfCondition  ]
                then 
                    echo "DELETED : "
                    echo $line
                else 
                    `echo $line >> temporayFileAfterDeletion`
                fi
            done < $tableToDelete
            `cat temporayFileAfterDeletion > $tableToDelete`
            `rm temporayFileAfterDeletion`
            cd .. 
            ./3.Connect.sh
        fi
