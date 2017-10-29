-- The procedures are simply the measure name and measure id, we do not need the other fields from the measuredates
create table if not exists Procedures as select MeasureName, MeasureID from measuredates;
