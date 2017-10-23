#!/bin/bash

THIS_SCRIPT=$(basename $0)
LOG_FILE="$HOME/${THIS_SCRIPT}.log"
QUIET="N"
VERBOSE="N"
DDL_SCRIPT_ONLY="N"
NO_HEADERS="N"
INPUT_FOLDER=/data/Exercise1
OUTPUT_HDFS_FOLDER=/user/w205/hospital_compare2
OUTPUT_SQL_SCRIPT="$HOME/hive_base_ddl.sql"
OLDIFS=$IFS

################################################################################
#	Function:		log_msg
#	Description:	Writes log to the logfile
################################################################################

log_msg ()
{
	if [[ $QUIET = "N" ]]
	then
    	echo -e "$(date): $*" >> $LOG_FILE
	fi
	if [[ $VERBOSE = "Y" ]]
	then
		echo -e "$(date): $*"
	fi
}

log_error ()
{
	log_msg "Error: $*"
}

################################################################################
#	Function:		print_help_and_exit
#	Description:	prints out the help information and exits the script
################################################################################

print_help_and_exit()
{
	echo -e "$(tput bold)Usage:$(tput rmso): $THIS_SCRIPT [-h] [-q] [-v] [-s] [-n] [-l logfile] [-i inputdirectory] [-d destinationdirectory] [-o outputScript]"
	echo -e "\t\t -h\t\t Display the help and exit"
	echo -e "\t\t -q\t\t Quiet, no logging to file"
	echo -e "\t\t -v\t\t Verbose, write all logs to the terminal.  If used with -q only writes to the terminal"
	echo -e "\t\t -r\t\t Do NOT remove spaces and dashes from filenames (removed by default)"
	echo -e "\t\t -s\t\t SQL Script only, do not copy files to data lake"
	echo -e "\t\t -n\t\t Indicates that no header line is expected in the CSV files, implies -s"
	echo -e "\t\t -l logfile\t Alternative log file from default (default $LOG_FILE)"
	echo -e "\t\t -i inputDirectory\t Input Directory for source CSV files"
	echo -e "\t\t -d destinationDirectory\t Destination directory in HDFS data lake"
	echo -e "\t\t -o OutputScript \t Hive DDL SQL Script for the copied files"
	echo -e "$(tput bold)Description:$(tput rmso) This script looks for CSV files in the input directory, copies these"
	echo -e "to the output directory removing the first line if it is a header (see -n).  Also a DDL script for Hive"
	echo -e "will be created to allow easy creation of the database tables from these files.  This uses the header line"
	echo -e "in each file and assumes all fields are strings (can be overwritten in the output file if necessary)."
	echo -e ""
	echo -e "$(tput bold)Assumptions:$(tput rmso)"
	echo -e "\t - Input files are suffixed by .csv"
	echo -e "\t - All files in a particular folder to be copied"
	echo -e "\t - Each file will be put in its own subfolder under the root destination folder"
	echo -e "\t - Files have a first line which is the header naming all the fields.  This can be overridden"
	echo -e "\t - Files will have spaces and dashed removed from the filename unless overridden"
	echo -e "\t - The destination directory is on an HDFS filesystem"
	exit
}

################################################################################
#	Function:		get_command_line_options
#	Descripition:	Reads in the command line and prints out the help on errors
################################################################################

get_command_line_options ()
{
	while getopts h?qvsnl:i:d:o: option
	do
		case $option in
			q)	QUIET="Y"
				;;
			v)	VERBOSE="Y"
				;;
			s)	DDL_SCRIPT_ONLY="Y"
				;;
			n)	NO_HEADERS="Y"
				;;
			l)	if [[ -f $OPTARG ]]
				then
					if [[ ! -w $OPTARG ]]
					then
						echo -e "File $OPTARG exists but is not writable"
						print_help_and_exit
					fi
				elif [[ ! -w $(dirname $OPTARG) ]]	# file does not exist, check that the directory is writable
				then
					echo -e "Cannot write to $(dirname $OPTARG)"
					print_help_and_exit
				fi
				LOG_FILE=$OPTARG
				;;

			i)	if [[ -d $OPTARG && -r $OPTARG ]]
				then
					INPUT_FOLDER=$OPTARG
				else
					echo -e "Directory $OPTARG does not exist or is not readable"
					print_help_and_exit
				fi
				;;
			d)	OUTPUT_HDFS_FOLDER=$OPTARG
				;;
			o)	OUTPUT_SQL_SCRIPT=$OPTARG
				;;
			h)	print_help_and_exit
				;;
			?)	print_help_and_exit
				;;
		esac
	done
}

################################################################################
#	Function:		create_or_verify_destination_hdfs_directory
#	Description:	Verifies that if the destination HDFS directory exists and
#					if not it attempts to create it.
################################################################################

create_or_verify_destination_hdfs_directory ()
{
	TMP_HDFS_DIR=$1
	hdfs dfs -test -d $TMP_HDFS_DIR 2>/dev/null 1>&2
	if [[ $? != 0 ]]
	then
		# directory does not exist
		hdfs dfs -mkdir $TMP_HDFS_DIR 2>/dev/null 1>&2
		if [[ $? != 0 ]]
		then
			log_error "Failed to create output directory $TMP_HDFS_DIR"
			return 1
		fi
	fi
	return 0
}

################################################################################
#	Function: 		create_ddl_sql_from_header
#	Description:	Take the first line out of the file as a list of fields. All
#					fields are assumed to be strings.  Write these to the output
#					SQL file defined in OUTPUT_SQL_SCRIPT.  Include the HDFS
#					directory as location of the datafile
################################################################################

create_ddl_sql_from_header ()
{
	INPUT_FILE=$1
	if [[ ! -f $INPUT_FILE ]]
	then
		log_error "Unable to find $1"
		exit 2
	fi
	DESTINATION_DIRECTORY=$2
	
	TableName=$(echo -e $(basename $INPUT_FILE) | tr -d " \-" | sed -e's/\(.*\).csv/\1/g')

	log_msg "Writing DDL for table $TableName to $OUTPUT_SQL_SCRIPT"

	echo -e "DROP TABLE $TableName;" >> $OUTPUT_SQL_SCRIPT
	echo -e "CREATE EXTERNAL TABLE $TableName" >> $OUTPUT_SQL_SCRIPT
	echo -e "(" >> $OUTPUT_SQL_SCRIPT
	COLUMNS_STRING=""
	PREIFS=$IFS
	IFS=$OLDIFS
	# Forgot about Carraige returns, they messed things up badly until I removed them
	for column in $(head -1 "$INPUT_FILE" | tr -d " \r\"\-" | tr "," " ")
	do
		if [[ ! -z $COLUMNS_STRING ]]
		then
			# this works around not needing a comma at the end of the last column definition
			COLUMNS_STRING="${COLUMNS_STRING},\n"
		fi
		#newcolname=$(echo $column | tr -d " \"\-")
		COLUMNS_STRING="${COLUMNS_STRING}\t$column STRING"
	done
	echo -e "${COLUMNS_STRING}\n)" >> $OUTPUT_SQL_SCRIPT
	echo -e "ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'" >> $OUTPUT_SQL_SCRIPT
	echo -e "WITH SERDEPROPERTIES ( \"separatorChar\" = \",\", \"quoteChar\" = '\"', \"escapeChar\" = '\\\\\')" >> $OUTPUT_SQL_SCRIPT
	echo -e "STORED AS TEXTFILE" >> $OUTPUT_SQL_SCRIPT
	echo -e "LOCATION \"$DESTINATION_DIRECTORY\";" >> $OUTPUT_SQL_SCRIPT
	echo -e "\n\n" >> $OUTPUT_SQL_SCRIPT
	IFS=$PREIFS
}

check_output_sql_file ()
{
	if [[ -f $OUTPUT_SQL_SCRIPT && ! -w $OUTPUT_SQL_SCRIPT ]]
	then
		echo -e "File $OUTPUT_SQL_SCRIPT exists but is not writable"
		print_help_and_exit
	elif [[ ! -f $OUTPUT_SQL_SCRIPT && ! -w $(dirname $OUTPUT_SQL_SCRIPT) ]]
	then
		echo -e "Cannot write to $(dirname $OUTPUT_SQL_SCRIPT)"
		print_help_and_exit
	elif [[ -f $OUTPUT_SQL_SCRIPT && -w $OUTPUT_SQL_SCRIPT ]]
	then
		/bin/cp $OUTPUT_SQL_SCRIPT ${OUTPUT_SQL_SCRIPT}.old
		cat /dev/null > $OUTPUT_SQL_SCRIPT	# empty it
	fi
}

main ()
{
	get_command_line_options $*
	log_msg "Starting script $THIS_SCRIPT execution"

	# check if we are only writing the DDL, if so no need to check the HDFS folder
	if [[ ! $DDL_SCRIPT_ONLY == "Y" ]]
	then
		create_or_verify_destination_hdfs_directory $OUTPUT_HDFS_FOLDER
		if [[ $? != 0 ]]
		then
			log_error "Failed to create root output folder in HDFS"
			print_help_and_exit
		fi
	fi

	# Verify that we can write an output SQL DDL file
	check_output_sql_file

	# Remove spaces from interpretation as end of file
	IFS=$'\n'

	for file in $INPUT_FOLDER/*csv
	do
		newname=$(echo -e $(basename $file) | tr -d " \-" )
		newdir=$(echo $newname | sed -e's/\(.*\).csv/\1/g')

		if [[ ! $DDL_SCRIPT_ONLY == "Y" ]]	# skip if we are only writing the output DDL file
		then

			log_msg "Creating directory on HDFS for file: $OUTPUT_HDFS_FOLDER/$newdir"

			create_or_verify_destination_hdfs_directory $OUTPUT_HDFS_FOLDER/$newdir
			if [[ $? != 0 ]]
			then
				log_error "Unable to create HDFS folder: $OUTPUT_HDFS_FOLDER/$newdir"
				exit 1
			fi

			if [[ $NO_HEADERS == "Y" ]]
			then
				log_msg "Copying $file to $OUTPUT_HDFS_FOLDER/$newname in HDFS lake"
				# no header file in the input files, copy straight
				hdfs dfs -put "$file" $OUTPUT_HDFS_FOLDER/$newname 2>/dev/null 1>&2
			else
				log_msg "Removing header and copying $file to $OUTPUT_HDFS_FOLDER/$newdir/$newname in HDFS lake"
				# headers exist, remove them.  Also use standard out and standard in rather
				# than creating temporary files, much more efficient
				tail -n +2 "$file" | hdfs dfs -put - $OUTPUT_HDFS_FOLDER/$newdir/$newname 2>/dev/null 1>&2
			fi
			# check that the copy was a success
			hdfs dfs -test -f $OUTPUT_HDFS_FOLDER/$newdir/$newname 2>/dev/null 1>&2
			if [[ $? != 0 ]]
			then
				log_error "Copying file $file to $OUTPUT_HDFS_FOLDER/$newname failed, please check and try again"
				exit
			fi
		fi
		# now create the script from the header of the file
		if [[ $NO_HEADERS != "Y" ]]
		then
			create_ddl_sql_from_header $file "$OUTPUT_HDFS_FOLDER/$newdir"
		fi
		IFS=$'\n'
	done
}

main $*
log_msg "Ending script $THIS_SCRIPT execution"
