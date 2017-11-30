import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# simple query returning all words in alphabetical order with their count
def queryAll( conn ) :
    cur = conn.cursor()
    cur.execute( "SELECT count FROM tweetwordcount where count=20 ORDER BY word" )
    print("paul: %s" % (cur.rowcount))
    if cur.rowcount == 0:
        cur.execute("INSERT INTO tweetwordcount (word,count) VALUES (%s, 1)", (word,));
#    elif cur.rowcount != 1:
#        print "error, more than one row returned for"
    else:
        curval = cur.fetchone()[0]
        #cur.execute("UPDATE tweetwordcount SET count=%s WHERE word=%s", (uCount, uWord))
        print ("paul2: %s" % (curval))


# simple query returning a specif word in alphabetical order with their count
def queryWord( conn ,word ) :
    cur = conn.cursor()
    cur.execute( "SELECT word,count FROM tweetwordcount WHERE word =%s",(word,))
    for word, count in cur.fetchall() :
        print word, count


myConnection = psycopg2.connect( database="tcount", user="postgres", password="pass", host="localhost", port="5432")
if len(sys.argv) == 2: queryWord(myConnection, sys.argv[1])
else: queryAll(myConnection)
myConnection.close()
