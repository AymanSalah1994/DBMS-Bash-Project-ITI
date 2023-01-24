#!/bin/bash

function collectAllData
{
    typeset -i counter
    typeset -i index
    counter=1
    index=0
    while [ $index -ne $numberOfColumns ]
    do
        clear
        echo "Enter The TYPE Of Column Nubmer ${counter}"
        read -p "Enter 1 For String  , 2 for Integer ->$ " option
        case $option in
            1) 
            ArrOfTypes[$index]="str"
            ;;
            2) 
            ArrOfTypes[$index]="int"
            ;;
            *) echo "$option is not Valid ! Only 1,2 For STR Or INT "
            continue
            ;;
        esac

        read  -p  "Enter The NAME Of Column Nubmer ${counter} -$ " columnName
                if [[ $columnName =~ ^[a-zA-Z0-9_]+$ ]] 
                then 
                    ArrOfColNames[$index]=$columnName
                    if test -z $PK 
                        then 
                        echo "Is it the PRIMARY KEY?"
                        read -p "Write 1 For YES ~$ " option
                        case $option in
                            1) 
                            PK=$columnName
                            ArrOfColNames[$index]=${ArrOfColNames[0]}
                            ArrOfColNames[0]=$columnName
                            temp=${ArrOfTypes[$index]}
                            ArrOfTypes[$index]=${ArrOfTypes[0]}
                            ArrOfTypes[0]=$temp
                            ;;
                        esac
                        fi
                else 
                    clear
                    echo "Not Valid Name" ;
                    echo "ERROR  , Try Creating the Table Again"
                    ./3.1.CreateTable.sh 
                fi 
        ((index = index + 1))
        ((counter = counter + 1))
    done
}

PK=""
read  -p "Enter the Name of Table ->" tableName
if [[ $tableName =~ ^[a-zA-Z0-9_]+$ ]] 
        then 
            echo "Valid" ; 
            clear
            typeset -i numberOfColumns
            read  -p "Enter the Nubmer Of Columns For Table ->" numberOfColumns
                if [[ $numberOfColumns -gt 0 ]]
                then
                echo "Valid Number"
                collectAllData 
                else 
                echo "Not a Valid Number , Try again , Enter Number greater than 0"
                ./3.1.CreateTable.sh 
                fi
else 
echo "Not Valid Name" ;
./3.1.CreateTable.sh 
fi 



if test -z $PK 
    then 
    echo "ERROR , you Did Not Specify the Primary Key !"
    ./3.1.CreateTable.sh 
    else 
    cd $databaseName
    touch "$tableName"
    touch "+$tableName+types"
    echo ${ArrOfTypes[*]} > "+$tableName+types"
    touch "+$tableName+pk"
    echo "$PK" > "+$tableName+pk"
    touch "+$tableName+colNames"
    echo ${ArrOfColNames[*]} > "+$tableName+colNames"
    echo "Table is Created !"
    cd .. 
    ./3.Connect.sh
fi
