#! /bin/bash

filename="$1.md"
if [ ! -d $filename ] && [ ! -f $filename ];then
echo "---" > $filename
echo "title: $2" >> $filename
echo "date: `date +"%Y-%m-%d %H:%M:%S"`" >> $filename
echo "tags: " >> $filename
echo "---" >> $filename
echo "SUCCESS"
else
echo "!!!FILE ALREADY EXISTS!!!"
exit -1
fi
