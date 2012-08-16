#!/bin/sh
if [ ! "$#" -eq 2 ]
then
echo usage $0 configurationfile backupfolder
fi
if [ ! -d $2 ]
then
echo $2 folder not writable
exit 1
fi
cd $2
while read line
do
host=$(echo $line | awk -F":" '{ print $1 }')
path=$(echo $line | awk -F":" '{ print $2 }')
echo $host
echo $path
if [ ! -d $host ]
then
mkdir $host
fi
cd $host
rsync -avrt -e "ssh" $host:$path ./
cd ..
done < $1
