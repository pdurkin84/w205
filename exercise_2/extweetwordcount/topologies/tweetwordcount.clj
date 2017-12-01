(ns tweetwordcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetwordcount [options]
   [
    ;; spout configuration
    {"tweet-spout-a" (python-spout-spec
          options
          "spouts.tweets.Tweets"
          ["tweet"]
          :p 2
          )
    "tweet-spout-b" (python-spout-spec
          options
          "spouts.tweets.Tweets"
          ["tweet"]
          :p 1
          )
    }
    ;; parse bolt configuration a
    ;;  takes from the two "tweet-spout-a" spouts
    {"parse-tweet-bolt-a" (python-bolt-spec
          options
          {"tweet-spout-a" :shuffle}
          "bolts.parse.ParseTweet"
          ["word"]
          :p 1
	  )
    ;; parse bolt configuration b
    ;; takes from both "tweet-spout-a" spouts and the "tweet-spout-b" spout
    "parse-tweet-bolt-b" (python-bolt-spec
          options
          {"tweet-spout-a" :shuffle
          "tweet-spout-b" :shuffle}
          "bolts.parse.ParseTweet"
          ["word"]
          :p 1
          )
    ;; parse bolt configuration c
    ;;  takes from the "tweet-spout-b" spout only
    "parse-tweet-bolt-c" (python-bolt-spec
          options
          {"tweet-spout-b" :shuffle}
          "bolts.parse.ParseTweet"
          ["word"]
          :p 1
	  )
     ;; parse bolt configuration a
     ;; takes from all three parse bolts
     "count-bolt-a" (python-bolt-spec
          options
          {"parse-tweet-bolt-a" :shuffle
	   "parse-tweet-bolt-b"  :shuffle
	   "parse-tweet-bolt-c"  :shuffle}
          "bolts.wordcount.WordCounter"
          ["word" "count"]
          :p 1
          )
     ;; parse bolt configuration a
     ;; takes from parse bolts a and b
     "count-bolt-b" (python-bolt-spec
          options
          { "parse-tweet-bolt-a" :shuffle
	    "parse-tweet-bolt-b" :shuffle}
          "bolts.wordcount.WordCounter"
          ["word" "count"]
          :p 1
          )
    }
  ]
)
