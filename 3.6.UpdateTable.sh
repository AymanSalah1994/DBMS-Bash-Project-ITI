#!/bin/bash

read -p "Enter the Table you Want to UPDATE ON ->" tableToUpdate
cd $databaseName
lengthStringToArray=`wc +$tableToUpdate+colNames -w`
totalColumns=($lengthStringToArray) # Total nubmer of Columns 
namesLine=`cat +$tableToUpdate+colNames`
ArrayOfColNames=($namesLine)  # Columns Names to Show to the User 
echo  "Available Columns: $namesLine"
typesLine=`cat +$tableToUpdate+types`
ArrayOfTypes=($typesLine)  # int  , str ...etc 

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
# -->
# Till Now We Just Got the Column that we will Check Against 

# NOW We Start Asking For the column and The Value to Update 
# [x]
typeset -i indexOfUpdate
while true
    do
        read -p "Enter the Index of Column You WANT TO UPDATE ->" indexOfUpdate
        # 1 >> 0 For the ID as an Example 
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
 # To get REAL index 

let indexOfUpdate=indexOfUpdate-1
theValueType=${ArrayOfTypes[$indexOfUpdate]} # Str or Int 
echo "The Value Type For selection"
echo $theValueType
echo "The Final Index "
echo $indexOfUpdate
while true
    do
        read -p "Enter the Value of Column Test Against ->" valueOfUpdate
        # 1 >> 0 For the ID as an Example 
        if [ $theValueType = "int" ]
        # If we Remove Spaces around = It is like assginment and Will always be true
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

echo $indexOfUpdate
echo $valueOfUpdate
# [x]



# loop For int 
# TODO one For str


# --> 
# The loops [ Which are For Deletion Till Now Untill We edit it ]
        if [ $theValueType = "int" ]
        # Type Because Either -eq OR = 
        # If we Remove Spaces around = It is like assginment and Will always be true
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
            # after Loop Take all From temporay to Old File  Name 
            # Delete Temporary 
            `cat temporayFileAfterUpdate > $tableToUpdate`
            `rm temporayFileAfterUpdate `
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
            # after Loop Take all From temporay to Old File  Name 
            # Delete Temporary 
            `cat temporayFileAfterUpdate > $tableToUpdate`
            `rm temporayFileAfterUpdate `
        fi
