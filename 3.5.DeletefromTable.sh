#!/bin/bash

read -p "Enter the Table you Want to DELETE From ->" tableToDelete
# TODO chck Table Exist 
databaseName="DB_1"
cd $databaseName
lengthStringToArray=`wc +$tableToDelete+colNames -w`
totalColumns=($lengthStringToArray) # Total nubmer of Columns 
namesLine=`cat +$tableToDelete+colNames`
ArrayOfColNames=($namesLine)  # Columns Names to Show to the User 
echo  "Available Columns: $namesLine"
typesLine=`cat +$tableToDelete+types`
ArrayOfTypes=($typesLine) 


typeset -i indexOfCondition
while true
    do
        read -p "Enter the Index of Column You Choose as a Condition ->" indexOfCondition
        # 1 >> 0 For the ID as an Example 
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
((indexOfCondition = indexOfCondition -1 )) # To get REAL index 
theValueType=${ArrayOfTypes[$indexOfCondition]} # Str or Int 

while true
    do
        read -p "Enter the Value of Column Test Against ->" valueOfCondition
        # 1 >> 0 For the ID as an Example 
        if [ $theValueType="str" ] 
        then 
            if [[ $valueOfCondition =~ ^[a-zA-Z]+$ ]] 
            then 
            break
            else  
            echo " Not a Valid Type STR "
            continue
            fi
        fi

        if [ $theValueType="int" ]
        then
            if [[ $valueOfCondition =~ ^[0-9]+$ ]] 
            then 
            break
            else  
            echo " Not a Valid Type INT"
            continue
            fi
        fi
    done

echo $indexOfCondition
echo $valueOfCondition
