--!echo "A simple query, who has the best average score.  This will be biased since any hospital"
--!echo "that performs one task well will be at the top"

--SELECT 
	--hospitals.hospitalname,
	--hospitalScores.mean,
	--hospitalScores.totalscore,
	--hospitalScores.range,
	--hospitalScores.numprocedures
	--FROM hospitals JOIN hospitalScores ON hospitals.providerid = hospitalScores.providerid
--ORDER BY hospitalScores.mean DESC LIMIT 10;

--!echo "A less simple query, here we look for consistency which implies over a number of procedures"
--!echo "(chosing number 10 arbitrarily).  Any hospital with fewer procedures will not be considered"

--SELECT 
	--hospitals.hospitalname,
	--hospitalScores.mean,
	--hospitalScores.totalscore,
	--hospitalScores.range,
	--hospitalScores.numprocedures
	--FROM hospitals JOIN hospitalScores ON hospitals.providerid = hospitalScores.providerid 
	--WHERE hospitalscores.numprocedures>=10 
--ORDER BY hospitalScores.mean DESC LIMIT 10;

--!echo "Even more stringent since we have been asked for consistently high so we restrict the range"
--!echo "of scores to being all above 85%"

SELECT 
	hospitals.hospitalname,
	hospitalScores.mean,
	hospitalScores.totalscore,
	hospitalScores.range,
	hospitalScores.numprocedures
	FROM hospitals JOIN hospitalScores ON hospitals.providerid = hospitalScores.providerid 
	WHERE hospitalscores.numprocedures>=10 and hospitalscores.minimum > 85 
ORDER BY hospitalScores.mean DESC LIMIT 10;
