There are four sections here.
1. The Gist: quick guide to running the script in its easy form
2. Implementation, a few changes that were made to the data
3. The details.  An overview of what the script does
4. Help output of the script


The Gist:
=========
To easily run this have the following:
	- CSV files readable in /data/Exercise1
	- Directory $HOME exists and is writable, for logfile
	- Directory $HOME exists and is writable, for SQL DDL file
	- Directory /user/w205/ exists on an HDFS FS and is writable
	- Hive installed and running

Then run:
	load_data_lake.sh

This will copy all the CSV files from /data/Exercise1 removing the headers, to subfolders
under /user/w205/hospital_compare/, one for each file.  Then it will create the file
$HOME/hive_base_ddl.sql with the DDL for each of these files and load them into hive.

If any variation is required see the details below or run "load_data_lake.sh -?"

NOTE: the hive_base_ddl.sql script is not manually created but an automated output


Implementation:
==============

1. I updated the file FY2013_Percent_Change_in_Medicare_Payments.csv as it had odd 
unprinting characters in the header line, in HEX the output looked like:
efbb bf25 2043 6861 6e67 6520 696e 2042  ...% Change in B
the first three characters are unknown and caused corruptions in the SQL output

2. I removed the file "Medicare\ Hospital\ Spending\ by\ Claim.csv" is its field
names were 1, 2, 3 and so on.  These are not valid and caused exceptions.  I could
instead have implemented a function to rename this ("one", "two" and so on) but
decided it wasn't worth the time for this implementation.  A more thorough sanity
check of both the table and column names would be necessary for completeness


The Details:
============
The load_data_lake.sh is quite complex.  It does the following but many of these
options and the file and directory defaults can be overridden
- Parse the command line verifying the options provided.  Many default options can
	be overridden, output of the help is below.
- Sets up logging and a logfile unless explictly configured not to
- Verifies the source and destination folders for write and the location for the SQL
	output script
- if the SQL script exists then it backs up the original and truncates it
- Copies the files from the source to destination, renaming them to remove spaces and
	dashes and removing the header.  This transfer is done without creating 
	intermediate files
- Using the header it writes the SQL statements to drop an existing table and create 
	a new table using the file as the source.  All columns are defined as strings
- On success it can (with the -L option) load the SQL file into hive and create the
	database schema for the copied files.


Help output of script:
=======================
Usage:: load_data_lake.sh [-h] [-q] [-v] [-s] [-n] [-L] [-l logfile] [-i inputdirectory] [-d destinationdirectory] [-o outputScript]
		 -h              Display the help and exit
		 -q              Quiet, no logging to file
                 -v              Verbose, write all logs to the terminal.  If used with -q only writes to the terminal
                 -s              SQL Script only, do not copy files to data lake
                 -n              Indicates that no header line is expected in the CSV files, implies -s
                 -L              At the end load the SQL Script into hive
                 -l logfile      Alternative log file from default (default /home/w205/load_data_lake.sh.log)
                 -i inputDirectory       Input Directory for source CSV files
                 -d destinationDirectory         Destination directory in HDFS data lake
                 -o OutputScript         Hive DDL SQL Script for the copied files

Description: This script looks for CSV files in the input directory, copies these
to the output directory removing the first line if it is a header (see -n).  Also a DDL script for Hive
will be created to allow easy creation of the database tables from these files.  This uses the header line
in each file and assumes all fields are strings (can be overwritten in the output file if necessary).

Assumptions:
         - Input files are suffixed by .csv
         - All .csv files in a particular folder to be copied
         - Each file will be put in its own subfolder under the root destination folder
         - Files have a first line which is the header naming all the fields.  This can be overridden
         - Files will have spaces and dashed removed from the filename unless overridden
         - The destination directory is on an HDFS filesystem

