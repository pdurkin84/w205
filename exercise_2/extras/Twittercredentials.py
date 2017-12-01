import tweepy

consumer_key = "JgsCBhbvj5S94q5od6icfMOiwj";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "8ShclUq6t9X8jfSeAM8lVpYD7NyPMjkiuzRC6FVDeCShOMCHfd";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "934581358344790016-FV4ScMij9uvA9Lqn16Nm8clVQXQesuz";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "SWrFmv9LatPTz0fp7hamuIs3hvnG1v82ewV68lsuxDyPa";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



