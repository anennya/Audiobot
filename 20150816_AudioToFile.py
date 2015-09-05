#import espeak
import subprocess
text = "Hello world"
subprocess.call('espeak' +  text, shell=True)

"""def textToWav(text,file_name):
   subprocess.call(["espeak", "-w"+file_name+".wav", text])

textToWav('hello world','hello')
"""

"""import pyttsx

text = "Hello world"
engine = pyttsx.init()
output = engine.say(text)
print type(output)
"""


"""from comtypes.client import CreateObject
from comtypes.gen import SpeechLib    
engine = CreateObject("SAPI.SpVoice")
stream = CreateObject("SAPI.SpFileStream")
infile = "SHIVA.txt"
outfile = "SHIVA-audio.wav"
stream.Open(outfile, SpeechLib.SSFMCreateForWrite)
engine.AudioOutputStream = stream
f = open(infile, 'r')
theText = f.read()
f.close()
engine.speak(theText)
stream.Close()"""