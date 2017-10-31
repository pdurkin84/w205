The files in this directory transform the base files into tables matching the
ones found in the ERD (in the loading_and_modelling directory).

There are two ways that these files can be loaded
1) automatically.  From inside the folder run the setup.sh script
2) manually.  Load the *.sql files into either hive or spark-sql using the -f 
	flag.  Any files with the suffix _hive.sql should be loaded using hive

Transformation Details
======================
01-Hospitals_hive.sql
	This file creates a "StateNames" table with the names of the states, then joins
	this with the hospitalgeneralinformation table to create the Hospitals table

02-Procedures.sql
	This file creates a very basic table that extracts two columns from the measuredates 
	table

03-Survey.sql
	This file transforms the hvbp_hcahps_05_28_2015 table.  It does the following
	- for all fields with "X out of Y" it simply extracts the X value and converts
		it to a numeric
	- For any other score field it converts it to a numeric
	- it creates a PatientExperienceOfCareDomain field which is a sum of the base
		and consistency scores

04-ProcedureScores.sql
	This file extracts scores from the readmissionsanddeathshospital and 
	timelyandeffectivecarehospital doing the following:
	1) Removes any entries whose score is "Not Available".  These are not useful since the score is missing
	2) Inverts scores (subtracts from 100) where "lower" percentages are better.  This allows us to use
		all scores equally.  These procdures are:
		VTE_6, MORT_30_PN, PC_01, READM_30_HF, READM_30_COPD, MORT_30_STK, MORT_30_CABG, READM_30_PN, 
		READM_30_STK, READM_30_HIP_KNEE, MORT_30_AMI, MORT_30_COPD, MORT_30_HF, READM_30_CABG, 
		READM_30_AMI, READM_30_HOSP_WIDE
	3) Removes time based scores, see justification in documentation.  These measures are:
		ED_1b,OP_1,OP_18b,OP_20,OP_21,OP_3b,OP_5,OP_22,ED_2b
	4) Removed measures of type EDV this is the volume through the emergency department. These are not
		measures of quality
	5) Removed measures of type OP_22, these are the % of people who left without being seen.  These
		Are not a measure of quality

05-HospitalScores.sql
	This file creates a table with a number of scores calculated from the ProcedureScores table.
	There is one line per-hospital containing:
	- Maximum and minimum procedure scores
	- Range of scores (maximum minus the minimum)
	- Mean score
	- Number of scores that were recorded (and used for the calculations) for this hospital
	- Total sum of all scores
