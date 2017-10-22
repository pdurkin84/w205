#!/bin/bash

CSV_FOLDER=/data/Exercise1
OUTPUT_HDFS_FOLDER=/user/w205/hospital_compare

# Remove spaces from interpretation as end of file
IFS=$'\n'

if [[ $# -eq 1 ]]
then
	if [[ -d $1 ]]
	then
		# Assume this directory overrides the default location of the files
		CSV_FOLDER=$1
		echo "Using folder $CSV_FOLDER"
	fi
fi

# Test if the destination folder exists or not
hdfs dfs -test -d $OUTPUT_HDFS_FOLDER 2>/dev/null
if [[ $? != 0 ]]
then
	# directory does not exist
	hdfs dfs -mkdir $OUTPUT_HDFS_FOLDER
fi

for file in $CSV_FOLDER/*csv
do
	# Create the new name, removing - symbols and replaceing spcaes with _
	newname=$(echo $(basename $file) | tr " " "_" | tr -d "\-")
	echo "Removing header from $file and copying to $OUTPUT_HDFS_FOLDER/$newname"
	tail -n +2 $file | hdfs dfs -put - $OUTPUT_HDFS_FOLDER/$newname
done
