from __future__ import absolute_import, print_function, unicode_literals
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

from collections import Counter
from streamparse.bolt import Bolt

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
	self.conn = psycopg2.connect( database="tcount", user="postgres", password="pass", host="localhost", port="5432")
	self.cur = self.conn.cursor()
        self.counts = Counter()

    def process(self, tup):
        word = tup.values[0]

# My code
#	myConnection = psycopg2.connect( database="tcount", user="postgres", password="pass", host="localhost", port="5432")
#	cur = myConnection.cursor()
	self.cur.execute( "SELECT count FROM tweetwordcount WHERE word =%s",(word,))
	if self.cur.rowcount == 0:
		self.cur.execute("INSERT INTO tweetwordcount (word,count) VALUES (%s, 1)", (word,));
	elif self.cur.rowcount != 1:
		print ("error, more than one row returned for %s" % (word))
	else:
		curval = self.cur.fetchone()[0]
		curval += 1
		self.cur.execute("UPDATE tweetwordcount SET count=%s WHERE word=%s", (curval, word))
	
	self.conn.commit()

# End my code
        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount 
        # Table name: Tweetwordcount 
        # you need to create both the database and the table in advance.
        
#
#        # Increment the local count
#        self.counts[word] += 1
#        self.emit([word, self.counts[word]])
#
#        # Log the count - just to see the topology running
#        self.log('%s: %d' % (word, self.counts[word]))
