-- Correlation between the hospital mean and the survey (total) score
SELECT
	CORR(survey.patientexperienceofcaredomain, hospitalscores.mean)
	FROM hospitalscores JOIN SURVEY on survey.providerid=hospitalscores.providerid
	WHERE survey.patientexperienceofcaredomain is not NULL and hospitalscores.numprocedures > 10;

-- Correlation between the hospital range and the survey (total) score
SELECT
	CORR(survey.patientexperienceofcaredomain, hospitalscores.range)
	FROM hospitalscores JOIN SURVEY on survey.providerid=hospitalscores.providerid
	WHERE survey.patientexperienceofcaredomain is not NULL and hospitalscores.numprocedures > 10;
