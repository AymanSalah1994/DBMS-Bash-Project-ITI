#!/bin/bash


function promptForValue 
# index
{
    read -p "Enter the Value of ${ArrayOfColNames[$1]} ->$ " valueToInsert
    echo ${ArrayOfTypes[$1]}
    if test ${ArrayOfTypes[$1]} = "int" 
        then 
            if [[ $valueToInsert =~ ^[0-9]+$ ]]
            then
            insertedValues[$1]=$valueToInsert
            else 
            echo "NOT valid Data Type "
           return
            fi
    fi

    if test ${ArrayOfTypes[$1]} = "str" 
    then 
        if [[ $valueToInsert =~ ^[a-zA-Z]+$ ]] 
        # WHY in Function Here all work with Test only ?
        then
        insertedValues[$1]=$valueToInsert
        else 
        echo "NOT valid Data Type "
       return
        fi
    fi

    if test $1 -eq 0 
    then 
        for eachIdValue in `cat IdTemporaryFile`
            do 
                if [ $eachIdValue = $valueToInsert ] 
                then 
                echo "ID must Be Unique"
                return
                break
                fi
            done 
    fi
    insertedValues[$1]=$valueToInsert 
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
        while test $index -lt $numberOfColumns 
        # Start While 
        do
        # echo $index
        # echo ${ArrayOfTypes[$index]}
        # echo ${ArrayOfColNames[$index]}
        promptForValue $index
        let index=$index+1
        done
        # Done End of While 
        # End of the Loop Of Insertion
    else 
    echo "There is No table with this Name ! ERROR"
fi

# If Table File exist 
echo ${insertedValues[*]}




# APPEND not OverWrite 
# read -p "Enter Value Of ${ArrayOfColNames[$index]}->$ " insertValue
        # if [$index -eq 0]
        # then 
        # # Start Of the Loop For IDs
        # for eachIdValue in cat IdTemporaryFile
        #     do 
        #         if [$eachIdValue=$insertValue]
        #         then 
        #         echo "ID must Be Unique"
        #         break
        #         fi
        #     done 
        #     # Done Above is for for Loop
        # valuesArray[$index]=insertValue
        # let index=$index+1

        # else 
        # # Else if index is Not 0 


        # fi # End Of If index = 0 
