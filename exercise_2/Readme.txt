Running the application:
------------------------

Prerequisites
-------------
1) UCB MIDS W205 EX2-FULL image for AMI instance
2) Postgres installed and running
3) A copy of this repo from directory exercise_2 and below
4) tweepy installed in python (as root):
	pip install tweepy
5) Before running for the first time set up the database.  To do this go to the
	exercise_2/extweetwordcount/Scripts directory and do:
	python setupdb.py

Running the application
=======================
1) change directory into exercise_2/extweetwordcount/
2) run: sparse run
It will take about 30 seconds to start up and begin streaming in tweets

Using the Serving Scripts
=========================
finalresults.py	(in exercise_2/Scripts)
---------------
This script has two modes of operation, if a parameter is specified it will return the 
count for that word, and if no parameters are specified then it returns all words with
their counts in alphabetical order.
Usage:
	python finalresults.py [word]
Example:
	python finalresults.py  | sed -e 's/^\([^ ]*\), \(.*\)/\2 \1/g'|sort -rn | head -20
  returns the top twenty words in the database

histogram.py	(in exercise_2/Scripts)
------------
This script takes two parameters, a lowerbound count and an upperbound count.  It returns all
words whose count is between or equal to these two counts.
Usage:
	python histogram.py lowercount uppercount
Example:
	python histogram.py 100 1000
  Returns all words with a count from 100 to 1000
