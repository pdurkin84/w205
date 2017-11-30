import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# simple query returning all words in alphabetical order with their count
def queryAll( conn ) :
    cur = conn.cursor()
    cur.execute( "SELECT word,count FROM tweetwordcount ORDER BY word" )
    for word, count in cur.fetchall() :
        print word, count


# simple query returning a specif word in alphabetical order with their count
def queryWord( conn ,word ) :
    cur = conn.cursor()
    cur.execute( "SELECT word,count FROM tweetwordcount WHERE word =%s",(word,))
    if cur.rowcount == 0:
	print ("%s 0" % (word))
    else:
        for word, count in cur.fetchall() :
            print word, count


myConnection = psycopg2.connect( database="tcount", user="postgres", password="pass", host="localhost", port="5432")
if len(sys.argv) == 2: queryWord(myConnection, sys.argv[1])
else: queryAll(myConnection)
myConnection.close()
