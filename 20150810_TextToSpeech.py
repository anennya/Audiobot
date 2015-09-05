import pyttsx
#Import the necessary methods from tweepy library
import tweepy
from tweepy import OAuthHandler
import json
import pandas as pd
import re
import subprocess
#Variable that contains the user credentials to access Twitter API 
access_token = "14038162-tw8ldHxAIZF7RMwESoTolEgZ2sZwHLbrYpt2ojQOe"
access_token_secret = "EePQND2dbkz44QPKzOVjbUU9xfkyVpXOF2gZ5rBx0GtLR"
consumer_key = "SXvD2wyU1FwHXKsBQazcO1dhX"
consumer_secret = "xnCD8hRNhkx9jvOfr4rrYHpTSO5vfHcfe7u3dPddFK2EmEZPCA"
#This is a basic listener that just prints received tweets to stdout.

auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)	
recent_tweets = api.home_timeline()

tweets = []

for status in recent_tweets:
	json_str = json.dumps(status._json)
	tweet = json.loads(json_str)
	tweets.append(tweet)


engine = pyttsx.init()
for tweet in tweets:
	text = re.sub(r"http\S+", "", tweet['text'])
	#text = unicode(text).encode('utf-8')
	#username = unicode(tweet['user']['name']).encode('utf-8')
	command = tweet['user']['name'] + " tweeted " + text
	
	try:
		print command
		subprocess.call(['espeak ',command])
		#engine.say(command)
	except:
		skip =  "Skipping this tweet because " + tweet['user']['name'] + " didn't tweet in English."
		print skip
		#engine.say(skip)
		subprocess.call(['espeak ',skip])
		continue
	#engine.runAndWait()

"""status = recent_tweets[0]
json_str = json.dumps(status._json)
tweet = json.loads(json_str)"""
