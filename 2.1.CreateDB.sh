# It will Ask For the DB
# If DB Exist , NO you Cant create One 
# Else Create a Directory For the DB and tell the user 
# Also Connet Him to the DB Directly 
echo ""
read  -p "Enter the Name of the DataBase ->" databaseName

if  test $databaseName =~ ^[a-zA-Z0-9]+$ 

then 
echo "Valid" ; 
else 
echo "Not Valid Name" ;
fi 

