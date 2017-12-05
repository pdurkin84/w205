from __future__ import absolute_import, print_function, unicode_literals
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

from collections import Counter
from streamparse.bolt import Bolt

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
# Pauld: code added here
	self.conn = psycopg2.connect( database="tcount", user="postgres", password="pass", host="localhost", port="5432")
	self.cur = self.conn.cursor()
#        self.counts = Counter()
# end of changes

    def process(self, tup):
        word = tup.values[0]

# Pauld: code added here
	self.cur.execute( "SELECT count FROM tweetwordcount WHERE word =%s",(word,))
	if self.cur.rowcount == 0:
		print ("Pauld, 0 row returned for %s" % (word))
		try:
			self.cur.execute("INSERT INTO tweetwordcount (word,count) VALUES (%s, 1)", (word,));
		except psycopg2.IntegrityError:
  			print("Race condition, ignoring when return from select is 0 but attempt to add fails")
	elif self.cur.rowcount != 1:
		print ("error, more than one row returned for %s" % (word))
	else:
		curval = self.cur.fetchone()[0]
		curval += 1
		self.cur.execute("UPDATE tweetwordcount SET count=%s WHERE word=%s", (curval, word))

	self.conn.commit()
# end of changes

# Pauld: removed everything after this point
#
#        # Increment the local count
#        self.counts[word] += 1
#        self.emit([word, self.counts[word]])
#
#        # Log the count - just to see the topology running
#        self.log('%s: %d' % (word, self.counts[word]))
