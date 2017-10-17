DROP TABLE HospitalGeneralInformation;
CREATE EXTERNAL TABLE HospitalGeneralInformation
	(Provider_ID	STRING,
	Hospital_Name	STRING,
	Address	STRING,
	City	STRING,
	State	STRING,
	ZIP_Code	STRING,
	County_Name	STRING,
	Phone_Number	STRING,
	Hospital_Type	STRING,
	Hospital_Ownership	STRING,
	Emergency_Services	STRING
	)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/Hospital_General_Information/';


DROP TABLE hvbp_hcahps_05_28_2015;
CREATE EXTERNAL TABLE hvbp_hcahps_05_28_2015
	(Provider_Number	STRING,
	Hospital_Name	STRING,
	Address	STRING,
	City	STRING,
	State	STRING,
	ZIP_Code	STRING,
	County_Name	STRING,
	Communication_with_Nurses_Achievement_Points	STRING,
	Communication_with_Nurses_Improvement_Points	STRING,
	Communication_with_Nurses_Dimension_Score	STRING,
	Communication_with_Doctors_Achievement_Points	STRING,
	Communication_with_Doctors_Improvement_Points	STRING,
	Communication_with_Doctors_Dimension_Score	STRING,
	Responsiveness_of_Hospital_Staff_Achievement_Points	STRING,
	Responsiveness_of_Hospital_Staff_Improvement_Points	STRING,
	Responsiveness_of_Hospital_Staff_Dimension_Score	STRING,
	Pain_Management_Achievement_Points	STRING,
	Pain_Management_Improvement_Points	STRING,
	Pain_Management_Dimension_Score	STRING,
	Communication_about_Medicines_Achievement_Points	STRING,
	Communication_about_Medicines_Improvement_Points	STRING,
	Communication_about_Medicines_Dimension_Score	STRING,
	Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points	STRING,
	Cleanliness_and_Quietness_of_Hospital_Environment_Improvement_Points	STRING,
	Cleanliness_and_Quietness_of_Hospital_Environment_Dimension_Score	STRING,
	Discharge_Information_Achievement_Points	STRING,
	Discharge_Information_Improvement_Points	STRING,
	Discharge_Information_Dimension_Score	STRING,
	Overall_Rating_of_Hospital_Achievement_Points	STRING,
	Overall_Rating_of_Hospital_Improvement_Points	STRING,
	Overall_Rating_of_Hospital_Dimension_Score	STRING,
	HCAHPS_Base_Score	STRING,
	HCAHPS_Consistency_Score	STRING
	)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/hvbp_Efficiency_05_20_2015';

DROP TABLE Measure_Dates;
CREATE EXTERNAL TABLE Measure_Dates 
	(Measure_Name	STRING,
	Measure_ID	STRING,
	Measure_Start_Quarter	STRING,
	Measure_Start_Date	STRING,
	Measure_End_Quarter	STRING,
	Measure_End_Date	STRING
	)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/Measure_Dates';

DROP TABLE Readmissions_and_Deaths__Hospital;
CREATE EXTERNAL TABLE Readmissions_and_Deaths__Hospital 
    (Provider_ID	STRING,
	Hospital_Name	STRING,
	Address	STRING,
	City	STRING,
	State	STRING,
	ZIP_Code	STRING,
	County_Name	STRING,
	Phone_Number	STRING,
	Measure_Name	STRING,
	Measure_ID	STRING,
	Compared_to_National	STRING,
	Denominator	STRING,
	Score	STRING,
	Lower_Estimate	STRING,
	Higher_Estimate	STRING,
	Footnote	STRING,
	Measure_Start_Date	STRING,
	Measure_End_Date	STRING
	)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/Readmissions_and_Deaths__Hospital';

DROP TABLE Timely_and_Effective_Care__Hospital;
CREATE EXTERNAL TABLE Timely_and_Effective_Care__Hospital
    (Provider_ID	STRING,
	Hospital_Name	STRING,
	Address	STRING,
	City	STRING,
	State	STRING,
	ZIP_Code	STRING,
	County_Name	STRING,
	Phone_Number	STRING,
	Condition	STRING,
	Measure_ID	STRING,
	Measure_Name	STRING,
	Score	STRING,
	Sample	STRING,
	Footnote	STRING,
	Measure_Start_Date	STRING,
	Measure_End_Date	STRING
	)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/Timely_and_Effective_Care__Hospital';
