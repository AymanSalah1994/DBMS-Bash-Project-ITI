#!/bin/bash
echo "Enter a Number to Select An option From the Menu Below !"
PS3="-~$ "
select option in "->Press 1 To Create a Database" "->Press 2 To List available Databases" "->Press 3 To Connect to a Database" "->Press 4 To Drop a Database"
do
case $REPLY in
1) 
./2.1.CreateDB.sh
exit;;

2)
./2.2.ListDatabases.sh
exit;;

3) 
./2.4.ConnectDatabase.sh
exit;;

4) echo "Fourth Option"
./2.3.DropDatabase.sh
exit;;

*) echo "$REPLY is not Valid ! Only 1,2,3,4 Are allowed !"
;;
esac
done
