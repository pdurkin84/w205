#!/bin/bash

# This script loads files into hive and spark-sql
# It has two modes
#	1) without command line options it looks for *.sql files in the current 
#		working directory
#	2) an input list of files is provided on the command line
# Any file with the name *_hive.sql is automatically loaded in hive, all others
# use spark-sql (if it can be found in the PATH environment)

THIS_SCRIPT=$(basename $0)
THIS_DIR=$(dirname $0)
FILE_LIST=""
HIVE_ONLY="N"


# check for the hive exectuable, if we can't find it exit
which hive 2>/dev/null 1>&2
if [[ $? != 0 ]]
then
	echo "Unable to find hive executable, please add to the PATH environment variable and try again"
	exit 1
fi

# Check for the spark-sql executable, if it can't be found just use hive instead
which spark-sql 2>/dev/null 1>&2
if [[ $? != 0 ]]
then
	echo "Unable to find spark-sql executable, switching to hive only mode"
	HIVE_ONLY="Y"
fi

if [[ $# -gt 0 ]]
then
	# assume that it is a file or list of files and use these as the input files
	for i in $*
	do
		if [[ -r $i ]]
		then
			FILE_LIST="$FILE_LIST $i"
		fi
	done
else
	FILE_LIST="*.sql"
fi

for i in $FILE_LIST
do
	if [[ $i == *"hive.sql" || HIVE_ONLY == "Y" ]]
	then
		echo "Hive file $i"
		hive -f $i
	else
		echo "SparkSQL file $i"
		spark-sql -f $i
	fi
done
