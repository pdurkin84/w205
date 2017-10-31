-- Load the Survey table removing all the "out of 9" and "out of 10" leaving just the scores
-- Also some aggregate columns
DROP TABLE SURVEY;
CREATE TABLE Survey AS SELECT
    providernumber AS providerid,
    CAST(REGEXP_EXTRACT(communicationwithnursesachievementpoints,'(.*?) out of.*',1) AS int) AS communicationwithnursesachievementpoints,
    CAST(REGEXP_EXTRACT(communicationwithnursesimprovementpoints,'(.*?) out of.*',1) AS int) AS communicationwithnursesimprovementpoints,
    CAST(REGEXP_EXTRACT(communicationwithnursesdimensionscore,'(.*?) out of.*',1) AS int) AS communicationwithnursesdimensionscore,
    CAST(REGEXP_EXTRACT(communicationwithdoctorsachievementpoints,'(.*?) out of.*',1) AS int) AS communicationwithdoctorsachievementpoints,
    CAST(REGEXP_EXTRACT(communicationwithdoctorsimprovementpoints,'(.*?) out of.*',1) AS int) AS communicationwithdoctorsimprovementpoints,
    CAST(REGEXP_EXTRACT(communicationwithdoctorsdimensionscore,'(.*?) out of.*',1) AS int) AS communicationwithdoctorsdimensionscore,
    CAST(REGEXP_EXTRACT(responsivenessofhospitalstaffachievementpoints,'(.*?) out of.*',1) AS int) AS responsivenessofhospitalstaffachievementpoints,
    CAST(REGEXP_EXTRACT(responsivenessofhospitalstaffimprovementpoints,'(.*?) out of.*',1) AS int) AS responsivenessofhospitalstaffimprovementpoints,
    CAST(REGEXP_EXTRACT(responsivenessofhospitalstaffdimensionscore,'(.*?) out of.*',1) AS int) AS responsivenessofhospitalstaffdimensionscore,
    CAST(REGEXP_EXTRACT(painmanagementachievementpoints,'(.*?) out of.*',1) AS int) AS painmanagementachievementpoints,
    CAST(REGEXP_EXTRACT(painmanagementimprovementpoints,'(.*?) out of.*',1) AS int) AS painmanagementimprovementpoints,
    CAST(REGEXP_EXTRACT(painmanagementdimensionscore,'(.*?) out of.*',1) AS int) AS painmanagementdimensionscore,
    CAST(REGEXP_EXTRACT(communicationaboutmedicinesachievementpoints,'(.*?) out of.*',1) AS int) AS communicationaboutmedicinesachievementpoints,
    CAST(REGEXP_EXTRACT(communicationaboutmedicinesimprovementpoints,'(.*?) out of.*',1) AS int) AS communicationaboutmedicinesimprovementpoints,
    CAST(REGEXP_EXTRACT(communicationaboutmedicinesdimensionscore,'(.*?) out of.*',1) AS int) AS communicationaboutmedicinesdimensionscore,
    CAST(REGEXP_EXTRACT(cleanlinessandquietnessofhospitalenvironmentachievementpoints,'(.*?) out of.*',1) AS int) AS cleanlinessandquietnessofhospitalenvironmentachievementpoints,
    CAST(REGEXP_EXTRACT(cleanlinessandquietnessofhospitalenvironmentimprovementpoints,'(.*?) out of.*',1) AS int) AS cleanlinessandquietnessofhospitalenvironmentimprovementpoints,
    CAST(REGEXP_EXTRACT(cleanlinessandquietnessofhospitalenvironmentdimensionscore,'(.*?) out of.*',1) AS int) AS cleanlinessandquietnessofhospitalenvironmentdimensionscore,
    CAST(REGEXP_EXTRACT(dischargeinformationachievementpoints,'(.*?) out of.*',1) AS int) AS dischargeinformationachievementpoints,
    CAST(REGEXP_EXTRACT(dischargeinformationimprovementpoints,'(.*?) out of.*',1) AS int) AS dischargeinformationimprovementpoints,
    CAST(REGEXP_EXTRACT(dischargeinformationdimensionscore,'(.*?) out of.*',1) AS int) AS dischargeinformationdimensionscore,
    CAST(REGEXP_EXTRACT(overallratingofhospitalachievementpoints,'(.*?) out of.*',1) AS int) AS overallratingofhospitalachievementpoints,
    CAST(REGEXP_EXTRACT(overallratingofhospitalimprovementpoints,'(.*?) out of.*',1) AS int) AS overallratingofhospitalimprovementpoints,
    CAST(REGEXP_EXTRACT(overallratingofhospitaldimensionscore,'(.*?) out of.*',1) AS int) AS overallratingofhospitaldimensionscore,
    CAST(hcahpsbasescore AS int) AS hcahpsbasescore,
    CAST(hcahpsconsistencyscore AS int) AS hcahpsconsistencyscore,
    -- May be useful AS a comparison against the mean scores for the hospital
    hcahpsbasescore/80 AS hcahpsbasescoremean,
	(hcahpsbasescore + hcahpsconsistencyscore) AS PatientExperienceOfCareDomain
	FROM hvbp_hcahps_05_28_2015
	WHERE hcahpsbasescore is not null AND hcahpsbasescore <> '' AND hcahpsconsistencyscore is not null AND hcahpsconsistencyscore <> '';
