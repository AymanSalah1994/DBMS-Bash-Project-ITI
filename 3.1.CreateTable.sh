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
            1) echo "String"
            ArrOfTypes[$index]="str"
            ;;
            2) echo "Integer"
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
                    # For Primary Key We Can Use Many Ways 
                    if test -z $PK 
                    # IF it is set , we will Not ask again
                        then 
                    echo "Is it the PRIMARY KEY?"
                            read -p "Write 1 For YES ~$ " option
                        case $option in
                            1) echo "String"
                            PK=$columnName
                            ArrOfColNames[$index]=${ArrOfColNames[0]}
                            ArrOfColNames[0]=$columnName
                            temp=${ArrOfTypes[$index]}
                            ArrOfTypes[$index]=${ArrOfTypes[0]}
                            ArrOfTypes[0]=$temp
                            # NOTE: above  lines ensure always pk is 0 index
                            # Dollar Sign Means Value , without it 
                            # we Mean a Variable 
                            ;;
                        esac
                        fi
                        # #####
                else 
                clear
                echo "Not Valid Name" ;
                echo "ERROR  , Try Creating the Table Again"
                ./CreateTable.sh 
                # exit 1 ; 
                fi 
        ((index = index + 1))
        ((counter = counter + 1))
    done
}

# Once It is Created , You Can insert and Update and Delete ...etc 
PK=""
read  -p "Enter the Name of Table ->" tableName
if [[ $tableName =~ ^[a-zA-Z0-9_]+$ ]] 
        then 
            echo "Valid" ; 
            # TODO If table Exist then Break
            typeset -i numberOfColumns
            read  -p "Enter the Nubmer Of Columns For Table ->" numberOfColumns
                if [[ $numberOfColumns -gt 0 ]]
                then
                echo "Valid Number"
                # TODO enter the Loop For Creating the Structure
                collectAllData 
                else 
                echo "Not a Valid Number , Try again , Enter Number greater than 0"
                ./CreateTable.sh 
                fi
else 
echo "Not Valid Name" ;
./3.1.CreateTable.sh 
fi 

# echo ${ArrOfTypes[*]}
# echo ${ArrOfColNames[*]}
# echo "Primary"
# echo "$PK"
# TODO making a Check if PK is empty 


# https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value


if test -z $PK 
    then 
    echo "ERROR , you Did Not Specify the Primary Key !"
    else 
    cd $databaseName
    touch "$tableName"
    touch "+$tableName+types"
    echo ${ArrOfTypes[*]} > "+$tableName+types"
    touch "+$tableName+pk"
    echo "$PK" > "+$tableName+pk"
    touch "+$tableName+colNames"
    echo ${ArrOfColNames[*]} > "+$tableName+colNames"
fi


# SUDO CODE FOR CREATE TABLE 
# Create Table is All About Creation of the Struture Like any other DBMS 
# Once It is Created , You Can insert and Update and Delete ...etc 
# Ask For the Table Name 
# you ask for the number of coulmns 
# Make a loop for the Columns 
# In each Loop ask If the PK is to Specify Or Not 
# Three arrays to Fill three Files  [ pk , types , columns ]
# If No PK , no Creation  , IF Any Interruption , RE-Call the File 
# Create Table is For Creation OF Structure Only 
# The go out to see What else to Do in the Main Menu [insert or whatever ]
