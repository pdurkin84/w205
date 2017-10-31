The files in this directory transform the base files into tables matching the
ones found in the ERD (in the loading_and_modelling directory).

There are two ways that these files can be loaded
1) automatically.  From inside the folder run the setup.sh script
2) manually.  Load the *.sql files into either hive or spark-sql using the -f 
	flag.  Any files with the suffix _hive.sql should be loaded using hive
