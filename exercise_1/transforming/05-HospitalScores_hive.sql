-- This table does all the aggregations across the Procedure scores (ProcedureScores table) for each hospital.
-- Once created this table can be used for checking:
--  - Mean score for each hospital
--  - Total score for each hospital
--  - Maximum score achieved by each hospital
--  - Minimum score achieved by each hospital
--  - The number of scores each hospital submitted
--	- The range of values for each hospital (max-min)

DROP TABLE HospitalScores;

CREATE TABLE HospitalScores AS SELECT 
	AVG(score) AS mean,
	SUM(score) AS totalscore,
	MAX(score) AS maximum,
	MIN(score) AS minimum,
	COUNT(score) AS numprocedures,
	MAX(score)-MIN(score) AS range,
	providerid AS providerid
	FROM ProcedureScores 
	WHERE ProcedureScores.measureid IN (SELECT ProcedureScores.measureid FROM ProcedureScores) GROUP BY providerid;
