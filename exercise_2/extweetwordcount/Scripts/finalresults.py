import sys
import psycopg2

hostname = 'localhost'
username = 'postgres'
password = ''
database = 'tcount'

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
    for word, count in cur.fetchall() :
        print word, count


myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database )
if len(sys.argv) == 2: queryWord(myConnection, sys.argv[1])
else: queryAll(myConnection)
myConnection.close()
