
# Mingpei Dou, Raouf Atabeg, Jordi Cochegrus, Adam Salamayeh, Ishaan Kumar
# CS4483 Katchabaw
# 2 Mar 2023

extends AudioStreamPlayer2D

# uses depricated code from Flower-Charged
func _process(delta):
	playMusic() # play bgm

# loop soundtrack
func playMusic():
	if playing == false: # if bgm ended
		play() # restart bgm
