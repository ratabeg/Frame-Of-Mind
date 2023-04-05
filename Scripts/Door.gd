
# Mingpei Dou, Raouf Atabeg, Jordi Cochegrus, Adam Salamayeh, Ishaan Kumar
# CS4483 Katchabaw
# 2 Mar 2023

# door class, stores functionality for door
extends StaticBody2D

onready var player = get_node("../Player")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and len(player.keys) != 0:
		player.move_local_x(-380)
		player.move_local_y(-100)
		player.keys.remove(len(player.keys) - 1)
		
