SELECT 
	hospitals.stateName,
	sum(HospitalScores.totalscore)/sum(HospitalScores.numProcedures) as stateMean,
	sum(HospitalScores.totalscore) AS stateTotal,
	sum(HospitalScores.numProcedures) as stateProcTotal
	FROM hospitals JOIN hospitalScores ON hospitals.providerid = hospitalScores.providerid 
GROUP BY hospitals.stateName ORDER BY stateMean DESC LIMIT 10;
