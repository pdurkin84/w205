-- The procedures are simply the measure name and measure id, we do not need the other fields from the measuredates
DROP TABLE Procedures;
CREATE TABLE Procedures AS SELECT MeasureName, MeasureID FROM measuredates;
