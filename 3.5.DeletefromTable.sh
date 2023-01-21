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
        # 1 >> 0 For the ID as an Example 

        if [ $theValueType = "int" ]
        # If we Remove Spaces around = It is like assginment and Will always be true
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
# Loop and delete if there is A match 
