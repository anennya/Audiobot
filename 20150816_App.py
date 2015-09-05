import kivy
kivy.require('1.9.0')
import pyttsx
from kivy.app import App
from kivy.uix.widget import Widget
from kivy.uix.label import Label
#from plyer import tts
import subprocess
class GUI(Widget):
	def __init__(self,**kwargs):
		super(GUI,self).__init__(**kwargs)
		l = Label(text = "Trying text to speech")
		self.add_widget(l)

		self.speech()

	def speech(self):
		text = '"I already said Hello world from within the app. Now it is time to kick ass with tweets"'
		subprocess.call('espeak '+text, shell=True)

class MyApp(App):

	def build(self):
		#tts.speak("Hello world")
		app = GUI()
		return app
	

if __name__ == '__main__':
	MyApp().run()





