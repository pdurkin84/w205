The quickest and easiest way to run through this project is the following steps:

1) Ensure hive and spark-sql reachable through the PATH environment variable
	(in bash)
2) Put the 5 files into /data/Exercise1 (and make them readable by the user
	running this project).  These files are:
	/data/Exercise1/Hospital General Information.csv
	/data/Exercise1/hvbp_hcahps_05_28_2015.csv
	/data/Exercise1/Measure Dates.csv
	/data/Exercise1/Readmissions and Deaths - Hospital.csv
	/data/Exercise1/Timely and Effective Care - Hospital.csv
3) Ensure the directory /user/w205/ exists and is writable by the user running
	this project
4) enter the loading_and_modelling directory and run loading_and_modelling.sh
5) enter the transforming directory and run load.sh

After that the database is set up to run the investigations, you can enter any of
the directories under investigations, run the load.sh and the results should be
printed out to the terminal.  See the .txt files in each folder for further
explanation, or the README.pdf for an overview of the project
