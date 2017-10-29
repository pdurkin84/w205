-- Load the Survey table removing all the "out of 9" and "out of 10" leaving just the scores
-- Also some aggregate columns
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
    cast(regexp_extract(cleanlinessandquietnessofhospitalenvironmentachievementpoints,'(.*?) out of.*',1) as int) as cleanlinessandquietnessofhospitalenvironmentach
ievementpoints,
    cast(regexp_extract(cleanlinessandquietnessofhospitalenvironmentimprovementpoints,'(.*?) out of.*',1) as int) as cleanlinessandquietnessofhospitalenvironmentimp
rovementpoints,
    cast(regexp_extract(cleanlinessandquietnessofhospitalenvironmentdimensionscore,'(.*?) out of.*',1) as int) as cleanlinessandquietnessofhospitalenvironmentdimens
ionscore,
    cast(regexp_extract(dischargeinformationachievementpoints,'(.*?) out of.*',1) as int) as dischargeinformationachievementpoints,
    cast(regexp_extract(dischargeinformationimprovementpoints,'(.*?) out of.*',1) as int) as dischargeinformationimprovementpoints,
    cast(regexp_extract(dischargeinformationdimensionscore,'(.*?) out of.*',1) as int) as dischargeinformationdimensionscore,
    cast(regexp_extract(overallratingofhospitalachievementpoints,'(.*?) out of.*',1) as int) as overallratingofhospitalachievementpoints,
    cast(regexp_extract(overallratingofhospitalimprovementpoints,'(.*?) out of.*',1) as int) as overallratingofhospitalimprovementpoints,
    cast(regexp_extract(overallratingofhospitaldimensionscore,'(.*?) out of.*',1) as int) as overallratingofhospitaldimensionscore,
    cast(hcahpsbasescore as int) as hcahpsbasescore,
    cast(hcahpsconsistencyscore as int) as hcahpsconsistencyscore,
    -- May be useful as a comparison against the mean scores for the hospital
    hcahpsbasescore/80 as hcahpsbasescoremean,
	(hcahpsbasescore + hcahpsconsistencyscore) as PatientExperienceOfCareDomain
from hvbp_hcahps_05_28_2015;
