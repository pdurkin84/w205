!echo "A biAS result AS any hospitals with only 1 procedure can have 100% if that one procedure is good"
SELECT AVG(hospitalScores.mean) AS mean,hospitals.state AS state FROM hospitals JOIN hospitalScores ON hospitals.providerid = hospitalScores.providerid GROUP BY hospitals.state ORDER BY mean DESC LIMIT 10;
!echo "A less biAS result choosing hospitals that have at least 10 procedures to choose from"
SELECT AVG(HospitalScores.mean) AS mean,hospitals.state AS state FROM hospitals JOIN hospitalScores ON hospitals.providerid = hospitalScores.providerid WHERe hospitalscores.numprocedures>10 GROUP BY hospitals.state ORDER BY mean DESC LIMIT 10;
