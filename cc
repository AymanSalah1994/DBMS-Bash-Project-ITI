#!/bin/bash

while read line
do 
echo $line
ArrayOfColNames=($line)
echo ${ArrayOfColNames[1]} 
done < final
