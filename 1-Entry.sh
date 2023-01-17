#!/bin/bash
echo "Select An option From the Options Below !"
PS3="-~$ "
# This is the Main Menu that is Neded In the Task 
select option in "->Press 1 To Create a Database" "->Press 2 To List available Databases" "->Press 3 To Connect to a Database" "->Press 4 To Drop a Database"
do
case $REPLY in
1) echo "First Option"
# "->Press 1 To Create a Database") echo "First Option"
# 1) echo "First Option"
# NOTE: Both Above will Work But in Case Use $option and In select also Make it Option
# [x] Or you Can use the $REPLY standard and Use Numbers 
exit;;
2) echo "Second Option"
echo `./2.2.ListDatabases.sh`
# "->Press 2 To List available Databases") echo "Second Option"
exit;;
3)  echo "Third Option"
# "->Press 3 To Connect to a Database"
exit;;
4) echo "Fourth Option"
# "->Press 4 To Drop a Database"
exit;;
*) echo "$REPLY is not Valid ! Only 1,2,3"
;;
# NOTE: This is the Only One I made without Exit Since it will LOOP again ! 
# In other Words it will Not Close the Script 
esac
done
