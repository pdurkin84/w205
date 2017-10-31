-- This table is a merge and filter on the Readmissions and Timely and Effective Care tables.
-- It does the following changes to the data
--	1) Removes any entries whose score is "Not Available".  These are not useful since the score is missing
--	2) Inverts scores (subtracts from 100) where "lower" percentages are better.  This allows us to use
--		all scores equally
--	3) Removes time based scores, see justification in documentation.  These measures are:
--		ED_1b,OP_1,OP_18b,OP_20,OP_21,OP_3b,OP_5,OP_22,ED_2b
--	4) Removed measures of type EDV this is the volume through the emergency department. These are not 
--		measures of quality
--	5) Removed measures of type OP_22, these are the % of people who left without being seen.  These
--		Are not a measure of quality
--
-- Note: I also used inserts here AS I was unable to get the syntax correct the selects in a "UNION ALL"
--	for either hive or SparkSQL

DROP TABLE ProcedureScores;

CREATE TABLE ProcedureScores 
	(providerid    STRING,
     measureid  STRING,
     score  FLOAT);

INSERT INTO ProcedureScores SELECT providerid, measureid,
        if (measureid = "VTE_6" OR
            measureid = "MORT_30_PN" OR
            measureid = "PC_01" OR
            measureid = "READM_30_HF" OR
            measureid = "READM_30_COPD" OR
            measureid = "MORT_30_STK" OR
            measureid = "MORT_30_CABG" OR
            measureid = "READM_30_PN" OR
            measureid = "READM_30_STK" OR
            measureid = "READM_30_HIP_KNEE" OR
            measureid = "MORT_30_AMI" OR
            measureid = "MORT_30_COPD" OR
            measureid = "MORT_30_HF" OR
            measureid = "READM_30_CABG" OR
            measureid = "READM_30_AMI" OR
            measureid = "READM_30_HOSP_WIDE",
                100-CAST(score AS float), CAST(score AS float)
            ) AS score
            FROM readmissionsanddeathshospital WHERE score != "Not Available";

INSERT INTO ProcedureScores SELECT providerid, measureid,
        if (measureid = "VTE_6" OR
            measureid = "MORT_30_PN" OR
            measureid = "PC_01" OR
            measureid = "READM_30_HF" OR
            measureid = "READM_30_COPD" OR
            measureid = "MORT_30_STK" OR
            measureid = "MORT_30_CABG" OR
            measureid = "READM_30_PN" OR
            measureid = "READM_30_STK" OR
            measureid = "READM_30_HIP_KNEE" OR
            measureid = "MORT_30_AMI" OR
            measureid = "MORT_30_COPD" OR
            measureid = "MORT_30_HF" OR
            measureid = "READM_30_CABG" OR
            measureid = "READM_30_AMI" OR
            measureid = "READM_30_HOSP_WIDE",
                -- Either invert it by subtracting it from 100 or take the score AS is (converting to integer)
                100-CAST(score AS float), CAST(score AS float)
            ) AS score
            FROM timelyandeffectivecarehospital WHERE score != "Not Available" AND measureid != "EDV"
            AND measureid != "ED_1b" AND measureid != "OP_1" AND measureid != "OP_18b"
            AND measureid != "OP_20" AND measureid != "OP_21" AND measureid != "OP_3b"
            AND measureid != "OP_5" AND measureid != "OP_22" AND measureid != "ED_2b";
