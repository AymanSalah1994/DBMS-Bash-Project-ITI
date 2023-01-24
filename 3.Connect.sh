#!/bin/bash

# Database Name is Exported 
clear
echo "=============================="
echo "Connected To :$databaseName "
echo "=============================="
PS3="-~$ "
export databaseName
# This is Global Export To Any File 
select option in "->Press 1 To Create a Table" "->Press 2 To List Tables" "->Press 3 To Drop a Table" "->Press 4 To Insert to a Table"  "->Press 5 To Select from a Table" "->Press 6 To Delete From a Table" "->Press 7 To Update a Table"
do
case $REPLY in

1)
./3.1.CreateTable.sh 
exit;;


2) 
cd $databaseName
ls [a-zA-Z9-0_]*
cd .. 
read -p "Press Enter To Continue : " option
case $REPLY in
    *) 
    ./3.Connect.sh
    ;;
    esac
exit;;


3)
./3.2.DropTable.sh
exit;;


4)
./3.3.InsertTable.sh
exit;;


5)  
./3.4.SelectTable.sh
exit;;


6) echo "Delete From Table"
3.5.DeletefromTable.sh
# TODO Delete
exit;;


7) echo "Update n"
./3.6.UpdateTable.sh
# TODO Update
exit;;


*) echo "$REPLY is not Valid ! Only 1,2,3,4,5,6,7"
;;
esac
done
