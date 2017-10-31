-- for my usage since I do not know the state abbreviations
DROP TABLE StateNames;
CREATE TABLE StateNames (stateName	STRING, stateAbbreviation	STRING);

INSERT INTO TABLE StateNames
SELECT "Alabama","AL" UNION ALL
SELECT "Alaska","AK" UNION ALL
SELECT "Arizona","AZ" UNION ALL
SELECT "Arkansas","AR" UNION ALL
SELECT "California","CA" UNION ALL
SELECT "Colorado","CO" UNION ALL
SELECT "Connecticut","CT" UNION ALL
SELECT "Delaware","DE" UNION ALL
SELECT "Florida","FL" UNION ALL
SELECT "Georgia","GA" UNION ALL
SELECT "Hawaii","HI" UNION ALL
SELECT "Idaho","ID" UNION ALL
SELECT "Illinois","IL" UNION ALL
SELECT "Indiana","IN" UNION ALL
SELECT "Iowa","IA" UNION ALL
SELECT "Kansas","KS" UNION ALL
SELECT "Kentucky","KY" UNION ALL
SELECT "Louisiana","LA" UNION ALL
SELECT "Maine","ME" UNION ALL
SELECT "Maryland","MD" UNION ALL
SELECT "Massachusetts","MA" UNION ALL
SELECT "Michigan","MI" UNION ALL
SELECT "Minnesota","MN" UNION ALL
SELECT "Mississippi","MS" UNION ALL
SELECT "Missouri","MO" UNION ALL
SELECT "Montana","MT" UNION ALL
SELECT "Nebraska","NE" UNION ALL
SELECT "Nevada","NV" UNION ALL
SELECT "New Hampshire","NH" UNION ALL
SELECT "New Jersey","NJ" UNION ALL
SELECT "New Mexico","NM" UNION ALL
SELECT "New York","NY" UNION ALL
SELECT "North Carolina","NC" UNION ALL
SELECT "North Dakota","ND" UNION ALL
SELECT "Ohio","OH" UNION ALL
SELECT "Oklahoma","OK" UNION ALL
SELECT "Oregon","OR" UNION ALL
SELECT "Pennsylvania","PA" UNION ALL
SELECT "Rhode Island","RI" UNION ALL
SELECT "South Carolina","SC" UNION ALL
SELECT "South Dakota","SD" UNION ALL
SELECT "Tennessee","TN" UNION ALL
SELECT "Texas","TX" UNION ALL
SELECT "Utah","UT" UNION ALL
SELECT "Vermont","VT" UNION ALL
SELECT "Virginia","VA" UNION ALL
SELECT "Washington","WA" UNION ALL
SELECT "West Virginia","WV" UNION ALL
SELECT "Wisconsin","WI" UNION ALL
SELECT "Wyoming","WY" UNION ALL
SELECT "American Samoa","AS" UNION ALL
SELECT "District of Columbia","DC" UNION ALL
SELECT "Federated States of Micronesia","FM" UNION ALL
SELECT "Guam","GU" UNION ALL
SELECT "Marshall Islands","MH" UNION ALL
SELECT "Northern Mariana Islands","MP" UNION ALL
SELECT "Palau","PW" UNION ALL
SELECT "Puerto Rico","PR" UNION ALL
SELECT "Virgin Islands","VI";

-- Join the Hospitals with the state name so that I can do a SELECT from it using the statename rather than
-- the two digit abbreviation
DROP TABLE Hospitals;
CREATE TABLE Hospitals as SELECT 
	hospitalgeneralinformation.providerid,
	hospitalgeneralinformation.hospitalname,
	hospitalgeneralinformation.address,
	hospitalgeneralinformation.city,
	hospitalgeneralinformation.state,
	hospitalgeneralinformation.zipcode,
	hospitalgeneralinformation.countyname,
	hospitalgeneralinformation.phonenumber,
	hospitalgeneralinformation.hospitaltype,
	hospitalgeneralinformation.hospitalownership,
	hospitalgeneralinformation.emergencyservices,
	statenames.stateName 
	from hospitalgeneralinformation join statenames on hospitalgeneralinformation.state = statenames.stateAbbreviation;
