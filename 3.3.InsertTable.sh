#!/bin/bash

function promptForValue 
# Takes Index 
{
    while true 
    do
    read -p "Enter the Value of ${ArrayOfColNames[$1]} ->$ " valueToInsert
    if [ "$1" -eq 0 ]
    then 
        for eachIdValue in `cat IdTemporaryFile`
            do 
                if [ $eachIdValue = $valueToInsert ] 
                then 
                echo "ID must Be Unique"
                continue 2
                fi
            done
            if test ${ArrayOfTypes[$1]} = "int" 
                then 
                    if [[ $valueToInsert =~ ^[0-9]+$ ]]
                    then
                    echo
                    else 
                    echo "NOT valid Data Type "
                    continue
                    fi
            fi

            if test ${ArrayOfTypes[$1]} = "str" 
            then 
                if [[ $valueToInsert =~ ^[a-zA-Z]+$ ]] 
                then
                echo
                else 
                echo "NOT valid Data Type "
                continue
                fi
            fi

    else 
    # Else if NOT ZERO 
    if test ${ArrayOfTypes[$1]} = "int" 
        then 
            if [[ $valueToInsert =~ ^[0-9]+$ ]]
            then
            insertedValues[$1]=$valueToInsert
            break
            else 
            echo "NOT valid Data Type "
            continue
            fi
    fi

    if test ${ArrayOfTypes[$1]} = "str" 
    then 
        if [[ $valueToInsert =~ ^[a-zA-Z]+$ ]] 
        then
        insertedValues[$1]=$valueToInsert
        break
        else 
        echo "NOT valid Data Type "
        continue
        fi
    fi
fi

    insertedValues[$1]=$valueToInsert 
    break
    done
    
}


read -p "Enter the Name of the Table For Insertion ->$ " tableToInsert
cd $databaseName
if [ -f $tableToInsert ]
    then 
        primary=`cat +$tableToInsert+pk`
        lengthStringToArray=`wc +$tableToInsert+colNames -w`
        lengthArray=($lengthStringToArray)
        typeset -i numberOfColumns
        numberOfColumns=${lengthArray[0]}
        # Now we Have Nubmer of Columns 
        echo `cut -f1 -d' ' $tableToInsert > IdTemporaryFile`
        # Now we Have All IDs From the Table 
        namesLine=`cat +$tableToInsert+colNames`
        ArrayOfColNames=($namesLine) 
        typesLine=`cat +$tableToInsert+types`
        ArrayOfTypes=($typesLine) 
        # Now We Have Two Arrays , For Col-Names and Types for Validation

        # Now Lets Start the Loop Of Insertion
        index=0
        echo "All Cols $numberOfColumns"
        echo $namesLine
        while test $index -lt $numberOfColumns 
        # Start While 
        do
        promptForValue $index
        let index=$index+1
        done
        # Done End of While 
        # End of the Loop Of Insertion

        echo ${insertedValues[*]} >> "$tableToInsert"
        rm IdTemporaryFile
        cd ..
        notify-send  --icon=$PWD/check.png  $databaseName "Data Inserted"
        ./3.Connect.sh
    else 
    cd ..
    notify-send  --icon=$PWD/cancel.png  $databaseName "There is No table with this Name ! ERROR"
    ./3.Connect.sh
fi
