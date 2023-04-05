
# Mingpei Dou, Raouf Atabeg, Jordi Cochegrus, Adam Salamayeh, Ishaan Kumar
# CS4483 Katchabaw
# 2 Mar 2023

# camera class, handles camera toggling
extends Camera2D

# toggles view between cam 1 and 2
func _process(delta):
	get_parent().player.cam1.use_global_coordinates = !get_parent().player.swapCam
	get_parent().player2.cam2.use_global_coordinates = get_parent().player.swapCam
