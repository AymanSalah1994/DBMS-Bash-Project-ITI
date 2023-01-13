#!/bin/bash
echo "Select An option From the Options Below !"

# This is the Main Menu that is Neded In the Task 
select option in "->Press 1 To Create a Database" "->Press 2 To List available Databases" "->Press 3 To Connect to a Database" "->Press 4 To Drop a Database"
# PS3="Please Choose a Number: "
do
case $option in
1) echo "First Option"
# "->Press 1 To Create a Database") echo "First Option"
# 1) echo "First Option"
# NOTE: Both will Work 
;;
2) echo "Second Option"
# "->Press 2 To List available Databases") echo "Second Option"
;;
3)  echo "Third Option"
# "->Press 3 To Connect to a Database"
;;
4) echo "Fourth Option"
# "->Press 4 To Drop a Database"
;;
*) echo "$REPLY is not Valid ! Only 1,2,3"
;;
esac
done

# case $REPLY in
# 1)./createDB.sh
# exit;;
# 2) ./listDB.sh
# exit;;
# 3) ./connectDB.sh
# exit;;
# 4) ./dropDB.sh
# exit;;
