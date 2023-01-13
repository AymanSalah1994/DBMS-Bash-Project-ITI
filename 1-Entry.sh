#!/bin/bash
echo "Select An option From the Options Below !"

# This is the Main Menu that is Neded In the Task 
select option in "->Press 1 To Create a Database" "->Press 2 To List available Databases" "->Press 3 To Connect to a Database" "->Press 4 To Drop a Database"
# PS3="Please Choose a Number: "
do
case $option in
"->Press 1 To Create a Database") echo "First Option"
;;
"->Press 2 To List available Databases") echo "Second Option"
;;
"->Press 3 To Connect to a Database")  echo "Third Option"
;;
"->Press 4 To Drop a Database") echo "Fourth Option"
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
