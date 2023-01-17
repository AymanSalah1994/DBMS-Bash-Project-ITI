# NOTE: Since a Database = Directory ,,, Any Directory Means a DB ! 
echo `clear`
echo `ls -F  | grep "/" > dbnames` 
echo `wc -l dbnames`
echo \n
echo "*---------Databases with Their Tables-------------*"
echo \n
for eachTable in `cat dbnames`
do
echo \n
echo $eachTable 
ls $eachTable
echo "===End Of DataBase===="

done
