import sys
import psycopg2

hostname = 'localhost'
username = 'postgres'
password = ''
database = 'tcount'

def queryRange( conn ,lowerbound, upperbound ) :
    cur = conn.cursor()
    cur.execute( "SELECT word,count FROM tweetwordcount WHERE count>=%s and count <=%s order by count",(lowerbound,upperbound))
    for word, count in cur.fetchall() :
        print("%s: %s" % (word,count))


myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database )
if len(sys.argv) == 3: queryRange(myConnection, sys.argv[1], sys.argv[2])
else: print "Usage: sys.argv[0] lowerbound upperbound"
myConnection.close()
