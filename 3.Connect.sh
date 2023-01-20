#!/bin/bash
# Connecting is ALL about "cd" to the Database Folder 

# Database Name is Exported 
echo "=============================="
echo "Connected To :$databaseName "
echo "=============================="
PS3="-~$ "
select option in "->Press 1 To Create a Table" "->Press 2 To List Tables" "->Press 3 To Drop a Table" "->Press 4 To Insert to a Table"  "->Press 5 To Select from a Table" "->Press 6 To Delete From a Table" "->Press 7 To Update a Table"
do
case $REPLY in
1) echo "Create Table"
export databaseName
./3.1.CreateTable.sh 
exit;;
2) echo "List Tables"
cd $databaseName
ls [a-zA-Z9-0_]*
exit;;
3)  echo "Drop Table"
export databaseName
./3.2.DropTable.sh
exit;;
4) echo "Insert into Table"
export databaseName
./3.3.InsertTable.sh
exit;;
5) echo "5 Option"
./2.3.DropDatabase.sh
exit;;
6) echo "6 Option"
./2.3.DropDatabase.sh
exit;;
7) echo "7 Option"
./2.3.DropDatabase.sh
exit;;
*) echo "$REPLY is not Valid ! Only 1,2,3,4,5,6,7"
;;
esac
done
