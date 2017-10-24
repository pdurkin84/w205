create table if not exists Hospitals as select * from hospitalgeneralinformation;
create table if not exists Survey as select * from hvbp_hcahps_05_28_2015;
-- The other tables all use providerid for the unique hospital identifier
alter table survey change providernumber providerid STRING;

create table if not exists Procedures as select MeasureName, MeasureID from measuredates;
create table if not exists Readmissions as select 
	providerid,
	measureid,
	comparedtonational, 
	denominator,
	score
	from readmissionsanddeathshospital where score != "Not Available";
create table if not exists RegularCare as select 
	providerid,
	measureid,
	condition,
	score
	from timelyandeffectivecarehospital where score != "Not Available";

-- Create a table storing the details for regular procedures (ones that happen in the Timely and Effective file)
-- This tables is for procedures that are based on percentages.  We ignore EDV as these are simply volumes of
-- patients through ER in a year
create table regularproceduresPerc as select distinct(Regularcare.measureid),procedures.measurename from Regularcare join Procedures on Regularcare.measureid = procedures.measureid where procedures.measurename not like "%Time%" or procedures.measurename != "EDV";

-- Create a table storing the details for regular procedures (ones that happen in the Timely and Effective file)
-- This tables is for procedures that are not based on percentages.  We ignore EDV as these are simply volumes of
-- patients through ER in a year
create table regularproceduresNotPerc as select distinct(Regularcare.measureid),procedures.measurename from Regularcare join Procedures on Regularcare.measureid = procedures.measureid where procedures.measurename like "%Time%" and procedures.measurename != "EDV";


-- Create a table storing the details for readmissions procedures that are based on Percentages
create table readmissionprocedures as select distinct(readmissions.measureid),procedures.measurename from readmissions join Procedures on readmissions.measureid = procedures.measureid;
