!echo "A bias result as any hospitals with only 1 procedure can have 100% if that one procedure is good"
select avg(hospitalScores.mean) as mean,hospitals.state as state from hospitals join hospitalScores on hospitals.providerid = hospitalScores.providerid group by hospitals.state order by mean;
!echo "A less bias result choosing hospitals that have at least 10 procedures to choose from"
select avg(hospitalScores.mean) as mean,hospitals.state as state from hospitals join hospitalScores on hospitals.providerid = hospitalScores.providerid where hospitalscores.numprocedures>10 group by hospitals.state order by mean desc limit 10;
