-- No changes necessary to the Hospitals information
create table if not exists Hospitals as select * from hospitalgeneralinformation;


-- Load the Survey table removing all the (out of 9 and out of 10 for the scores) and converting them to integers
create table if not exists Survey as select
	providernumber as providerid,
	cast(regexp_extract(communicationwithnursesachievementpoints,'(.*?) out of.*',1) as int) as communicationwithnursesachievementpoints,
	cast(regexp_extract(communicationwithnursesimprovementpoints,'(.*?) out of.*',1) as int) as communicationwithnursesimprovementpoints,
	cast(regexp_extract(communicationwithnursesdimensionscore,'(.*?) out of.*',1) as int) as communicationwithnursesdimensionscore,
	cast(regexp_extract(communicationwithdoctorsachievementpoints,'(.*?) out of.*',1) as int) as communicationwithdoctorsachievementpoints,
	cast(regexp_extract(communicationwithdoctorsimprovementpoints,'(.*?) out of.*',1) as int) as communicationwithdoctorsimprovementpoints,
	cast(regexp_extract(communicationwithdoctorsdimensionscore,'(.*?) out of.*',1) as int) as communicationwithdoctorsdimensionscore,
	cast(regexp_extract(responsivenessofhospitalstaffachievementpoints,'(.*?) out of.*',1) as int) as responsivenessofhospitalstaffachievementpoints,
	cast(regexp_extract(responsivenessofhospitalstaffimprovementpoints,'(.*?) out of.*',1) as int) as responsivenessofhospitalstaffimprovementpoints,
	cast(regexp_extract(responsivenessofhospitalstaffdimensionscore,'(.*?) out of.*',1) as int) as responsivenessofhospitalstaffdimensionscore,
	cast(regexp_extract(painmanagementachievementpoints,'(.*?) out of.*',1) as int) as painmanagementachievementpoints,
	cast(regexp_extract(painmanagementimprovementpoints,'(.*?) out of.*',1) as int) as painmanagementimprovementpoints,
	cast(regexp_extract(painmanagementdimensionscore,'(.*?) out of.*',1) as int) as painmanagementdimensionscore,
	cast(regexp_extract(communicationaboutmedicinesachievementpoints,'(.*?) out of.*',1) as int) as communicationaboutmedicinesachievementpoints,
	cast(regexp_extract(communicationaboutmedicinesimprovementpoints,'(.*?) out of.*',1) as int) as communicationaboutmedicinesimprovementpoints,
	cast(regexp_extract(communicationaboutmedicinesdimensionscore,'(.*?) out of.*',1) as int) as communicationaboutmedicinesdimensionscore,
	cast(regexp_extract(cleanlinessandquietnessofhospitalenvironmentachievementpoints,'(.*?) out of.*',1) as int) as cleanlinessandquietnessofhospitalenvironmentachievementpoints,
	cast(regexp_extract(cleanlinessandquietnessofhospitalenvironmentimprovementpoints,'(.*?) out of.*',1) as int) as cleanlinessandquietnessofhospitalenvironmentimprovementpoints,
	cast(regexp_extract(cleanlinessandquietnessofhospitalenvironmentdimensionscore,'(.*?) out of.*',1) as int) as cleanlinessandquietnessofhospitalenvironmentdimensionscore,
	cast(regexp_extract(dischargeinformationachievementpoints,'(.*?) out of.*',1) as int) as dischargeinformationachievementpoints,
	cast(regexp_extract(dischargeinformationimprovementpoints,'(.*?) out of.*',1) as int) as dischargeinformationimprovementpoints,
	cast(regexp_extract(dischargeinformationdimensionscore,'(.*?) out of.*',1) as int) as dischargeinformationdimensionscore,
	cast(regexp_extract(overallratingofhospitalachievementpoints,'(.*?) out of.*',1) as int) as overallratingofhospitalachievementpoints,
	cast(regexp_extract(overallratingofhospitalimprovementpoints,'(.*?) out of.*',1) as int) as overallratingofhospitalimprovementpoints,
	cast(regexp_extract(overallratingofhospitaldimensionscore,'(.*?) out of.*',1) as int) as overallratingofhospitaldimensionscore,
	cast(hcahpsbasescore as int) as hcahpsbasescore,
	cast(hcahpsconsistencyscore as int) as hcahpsconsistencyscore
from hvbp_hcahps_05_28_2015;

create table if not exists Procedures as select MeasureName, MeasureID from measuredates;

CREATE TABLE IF NOT EXISTS ReadmissionsAndRegularCare COMBINED AS
select * from

create table ReadmissionsAndRegularCare (providerid	STRING,
	 measureid	STRING,
	 score	FLOAT);

INSERT INTO ReadmissionsAndRegularCare SELECT providerid, measureid
		if (measureid = "VTE_6" OR
			measureid = "MORT_30_PN" OR
            measureid = "PC_01" OR
			measureid = "READM_30_HF" OR
			measureid = "READM_30_COPD" OR
			measureid = "MORT_30_STK" OR
			measureid = "MORT_30_CABG" OR
			measureid = "READM_30_PN" OR
			measureid = "READM_30_STK" OR
			measureid = "READM_30_HIP_KNEE" OR
			measureid = "MORT_30_AMI" OR
			measureid = "MORT_30_COPD" OR
			measureid = "MORT_30_HF" OR
			measureid = "READM_30_CABG" OR
			measureid = "READM_30_AMI" OR
			measureid = "READM_30_HOSP_WIDE",
				100-cast(score as float), cast(score as float)
			) as score,
			from readmissionsanddeathshospital where score != "Not Available";

--	Select all the measurements from the Timely and effective care where the score is available
--	and not selecting the following
--	- Any procedure described with "Median Time" in it  - these values are time, not percentages.
--		These are measureids: ED_1b OP_1 OP_18b OP_20 OP_21 OP_3b OP_5
--	- EDV as these are simply volumes of patients through ER in a year
-- 	- OP_22 which are individuals who left before being seen, not a measure of quality
-- 	- ED_2b which is another time measure
--	- Convert a number of scores from being "lower is better" to "higher is better" by subtracting
--		them from 100

INSERT INTO ReadmissionsAndRegularCare SELECT providerid, measureid,
        if (measureid = "VTE_6" OR
            measureid = "MORT_30_PN" OR
            measureid = "PC_01" OR
            measureid = "READM_30_HF" OR
            measureid = "READM_30_COPD" OR
            measureid = "MORT_30_STK" OR
            measureid = "MORT_30_CABG" OR
            measureid = "READM_30_PN" OR
            measureid = "READM_30_STK" OR
            measureid = "READM_30_HIP_KNEE" OR
            measureid = "MORT_30_AMI" OR
            measureid = "MORT_30_COPD" OR
            measureid = "MORT_30_HF" OR
            measureid = "READM_30_CABG" OR
            measureid = "READM_30_AMI" OR
            measureid = "READM_30_HOSP_WIDE",
                100-cast(score as float), cast(score as float)
            ) as score
            from timelyandeffectivecarehospital where score != "Not Available" and measureid != "EDV"
			and measureid != "ED_1b" and measureid != "OP_1" and measureid != "OP_18b" 
			and measureid != "OP_20" and measureid != "OP_21" and measureid != "OP_3b" 
			and measureid != "OP_5" and measureid != "EDV" and measureid != "OP_22" and measureid != "ED_2b";

create table hospitalScores as select avg(score) as mean,sum(score) as totalscore, max(score) as maximum, min(score) as minimum,count(score) as numprocedures, max(score)-min(score) as range, providerid from ReadmissionsAndRegularCare where ReadmissionsAndRegularCare.measureid in (select regularproceduresPerc.measureid from regularproceduresPerc) group by providerid;


-- This table is unnecessary for the results but was heavily used during analysis
create table if not exists Readmissions as select 
	providerid,
	measureid,
	comparedtonational, 
	denominator,
	if(measureid = "VTE_6", 100-cast(score as float), cast(score as float)) as score
	from readmissionsanddeathshospital where score != "Not Available";

-- Removing any scores that are not available and :
--	- EDV which is an indicator of the volume through the Emergency department but not a 
--		measure of quality or care (and has alphanumerics)
--	- VTE_6 is a value where lower % is better so we invert it to keep it in line with 
--		everything else and make the calculations easy
-- This table is unnecessary for the results but was heavily used during analysis
create table if not exists RegularCare as select
	providerid,
	measureid,
	condition,
	if(measureid = "VTE_6", 100-cast(score as float), cast(score as float)) as score
	from timelyandeffectivecarehospital where score != "Not Available" and measureid != "EDV";

-- Create a table storing the details for procedures measured in percentages
-- This tables is for procedures that are based on percentages.  We remove the following:
create table regularproceduresPerc as select distinct(ReadmissionsAndRegularCare.measureid),procedures.measurename from ReadmissionsAndRegularCare join Procedures on ReadmissionsAndRegularCare.measureid = procedures.measureid;

-- -- Create a table storing the details for readmissions procedures that are based on Percentages
-- create table readmissionprocedures as select distinct(readmissions.measureid),procedures.measurename from readmissions join Procedures on readmissions.measureid = procedures.measureid;


-- create table hospitalReadmissionScores as select avg(score) as mean,max(score) as maximum, min(score) as minimum,count(score) as numprocedures,providerid from readmissions where readmissions.measureid in (select readmissionprocedures.measureid from readmissionprocedures) group by providerid;
