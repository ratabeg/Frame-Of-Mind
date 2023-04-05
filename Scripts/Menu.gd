
# Mingpei Dou, Raouf Atabeg, Jordi Cochegrus, Adam Salamayeh, Ishaan Kumar
# CS4483 Katchabaw
# 2 Mar 2023

# menu class, loads menu

extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Start.grab_focus()
	OS.set_window_position(OS.get_screen_size()*0.5-OS.get_window_size()*0.5) # centre screen




func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/level1.tscn") # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
