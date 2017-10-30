SELECT 
	MAX(score)-MIN(score) AS range,
	MAX(score),
	MIN(score),
	procedurescores.measureid,
	procedures.measurename 
	FROM procedurescores JOIN procedures ON procedurescores.measureid=procedures.measureid 
	GROUP BY procedurescores.measureid, procedures.measurename 
	HAVING range=100
	ORDER BY range DESC;
