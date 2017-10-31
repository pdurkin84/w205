SELECT
	CORR(survey.patientexperienceofcaredomain, hospitalscores.mean)
	FROM hospitalscores JOIN SURVEY on survey.providerid=hospitalscores.providerid
	WHERE survey.patientexperienceofcaredomain is not NULL and hospitalscores.numprocedures > 10;
