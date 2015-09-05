from kivy.app import App
from kivy.uix.widget import Widget
from kivy.uix.button import Button
from kivy.uix.label import Label 
from kivy.uix.boxlayout import BoxLayout
import subprocess
import tweepy
from tweepy import OAuthHandler
import json
import re


class AudiobotNews(Widget):
	"""def speech(self,tweets):
		for tweet in tweets:
			text = re.sub(r"http\S+", "", tweet['text'])
			command = tweet['user']['name'] + " tweeted " + text
			try:
				subprocess.call(['espeak ',command])
			except:
				skip =  "Skipping this tweet because " + "this person is lame and does not speak the language of Audiobot."
				subprocess.call(['espeak ',skip])
				continue"""
		
#This is a basic listener that just prints received tweets to stdout.
	def load_tweets(self,access_token,access_token_secret,consumer_key,consumer_secret):
		auth = OAuthHandler(consumer_key, consumer_secret)
		auth.set_access_token(access_token, access_token_secret)
		api = tweepy.API(auth)	
		recent_tweets = api.home_timeline()
		tweets = []
		for status in recent_tweets:
			json_str = json.dumps(status._json)
			tweet = json.loads(json_str)
			tweets.append(tweet)
		return tweets



class AudiobotApp(App):
	access_token = "14038162-tw8ldHxAIZF7RMwESoTolEgZ2sZwHLbrYpt2ojQOe"
	access_token_secret = "EePQND2dbkz44QPKzOVjbUU9xfkyVpXOF2gZ5rBx0GtLR"
	consumer_key = "SXvD2wyU1FwHXKsBQazcO1dhX"
	consumer_secret = "xnCD8hRNhkx9jvOfr4rrYHpTSO5vfHcfe7u3dPddFK2EmEZPCA"
	stop_saying = False

	def build(self):
		wid = Widget()
		
		#self.news = AudiobotNews()
		self.tweets = self.load_tweets(self.access_token,self.access_token_secret,self.consumer_key,self.consumer_secret)
		
		listenbtn = Button(text = "Listen to tweets")
		listenbtn.bind(on_press = self.say_tweets)
		stopbtn = Button(text = "Stop listening")
		stopbtn.bind(on_press = self.stop_saying_tweets)

		label = Label(text = "Listen to tweets from your timeline!")

		layout = BoxLayout(size_hint=(1,None),height = 50)
		layout.add_widget(listenbtn)
		#layout.add_widget(stopbtn)
		layout.add_widget(label)
		layout2 = BoxLayout(size_hint=(1,None),height =  50)
		layout2.add_widget(stopbtn)

		parent = BoxLayout(orientation = 'vertical')
		#parent.add_widget(self.news)
		parent.add_widget(wid)
		parent.add_widget(layout)
		parent.add_widget(layout2)
		return parent

	def load_tweets(self,access_token,access_token_secret,consumer_key,consumer_secret):
		auth = OAuthHandler(consumer_key, consumer_secret)
		auth.set_access_token(access_token, access_token_secret)
		api = tweepy.API(auth)	
		recent_tweets = api.home_timeline()
		tweets = []
		for status in recent_tweets:
			json_str = json.dumps(status._json)
			tweet = json.loads(json_str)
			tweets.append(tweet)
		return tweets

	def say_tweets(self,obj):
		#self.news.speech(self.tweets)
		for tweet in self.tweets:
			if self.stop_saying == False:
				text = re.sub(r"http\S+", "", tweet['text'])
				command = tweet['user']['name'] + " tweeted " + text
				try:
					subprocess.call(['espeak ','-s','150',command])
				except:
					skip =  "Skipping this tweet because " + "this person is lame and does not speak the language of Audiobot."
					subprocess.call(['espeak ','-s','150','-ven-us+f4',skip])
					continue
			else:
				break
			

	def stop_saying_tweets(self,obj):
		self.stop_saying = True



if __name__ == '__main__':
	AudiobotApp().run()