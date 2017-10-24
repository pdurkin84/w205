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

