#!/bin/bash

select option in "->Press 1 To ls" "->Press 2 To ls -a" "->Press 3 To ls"
do
case $option in
"->Press 1 To ls") echo `ls`
;;
"->Press 2 To ls -a") echo `ls -a`
;;
"->Press 3 To ls") break
;;
*) echo "$REPLY is not Valid ! Only 1,2,3"
;;
esac
done
