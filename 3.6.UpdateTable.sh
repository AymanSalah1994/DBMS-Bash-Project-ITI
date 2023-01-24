#!/bin/bash
read -p "Enter the Table you Want to UPDATE ON ->" tableToUpdate
cd $databaseName
if [[ -f $tableToUpdate ]]
then 
    lengthStringToArray=`wc +$tableToUpdate+colNames -w`
    totalColumns=($lengthStringToArray) # Total nubmer of Columns 
    namesLine=`cat +$tableToUpdate+colNames`
    ArrayOfColNames=($namesLine)  # Columns Names to Show to the User 
    echo  "Available Columns: $namesLine"
    typesLine=`cat +$tableToUpdate+types`
    ArrayOfTypes=($typesLine) 
else 
    cd ..
    notify-send  --icon=$PWD/cancel.png  "No Such a Table !"
    ./3.Connect.sh 
fi

while true
    do
        read -p "Enter the Index of Column You Choose as a Condition ->" indexOfCondition
        if [[ $userInput =~ ^[a-zA-Z]+$ ]] 
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


# typeset -i indexOfUpdate
while true
    do
        read -p "Enter the Index of Column You WANT TO UPDATE ->" indexOfUpdate
        if [[ $userInput =~ ^[a-zA-Z]+$ ]] 
        then 
            echo "Numbers Only"
            continue
        fi

        if [ $indexOfUpdate -lt 1 -o  $indexOfUpdate -gt $totalColumns ]
        then
            echo "Invalid Index"
            continue
        else 
            break  # This Means Number is Valid 
        fi
    done

let indexOfUpdate=indexOfUpdate-1
theValueType=${ArrayOfTypes[$indexOfUpdate]} # Str or Int 
while true
    do
        read -p "Enter the Value of Column Test Against ->" valueOfUpdate
        if [ $theValueType = "int" ]
        then
            if [[ $valueOfUpdate =~ ^[0-9]+$ ]] 
            then 
            break
            else  
            echo " Not a Valid Type INT"
            continue
            fi
        fi

        if [ $theValueType = "str" ] 
        then 
            if [[ $valueOfUpdate =~ ^[a-zA-Z]+$ ]] 
            then 
            break
            else  
            echo " Not a Valid Type STR "
            continue
            fi
        fi
    done


    if [ $theValueType = "int" ]
        then
            while read line
            do 
            ArrayOfColValues2=($line)
                if [ ${ArrayOfColValues2[$indexOfCondition]} -eq $valueOfCondition  ]
                then 
                    echo "UPDATED : "
                    ArrayOfColValues2[$indexOfUpdate]=$valueOfUpdate
                    `echo ${ArrayOfColValues2[*]} >> temporayFileAfterUpdate`
                    echo ${ArrayOfColValues2[*]}
                else 
                    `echo $line >> temporayFileAfterUpdate`
                fi
            done < $tableToUpdate
            `cat temporayFileAfterUpdate > $tableToUpdate`
            `rm temporayFileAfterUpdate`
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
                    echo "UPDATED : "
                    ArrayOfColValues2[$indexOfUpdate]=$valueOfUpdate
                    `echo ${ArrayOfColValues2[*]} >> temporayFileAfterUpdate`
                    echo ${ArrayOfColValues2[*]}
                else 
                    `echo $line >> temporayFileAfterUpdate`
                fi
            done < $tableToUpdate
            `cat temporayFileAfterUpdate > $tableToUpdate`
            `rm temporayFileAfterUpdate `
            cd .. 
            ./3.Connect.sh
        fi
