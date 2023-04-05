
# Mingpei Dou, Raouf Atabeg, Jordi Cochegrus, Adam Salamayeh, Ishaan Kumar
# CS4483 Katchabaw
# 2 Mar 2023

extends Node2D

onready var player = get_node("../Player")

func _ready():
	$Area2D.connect("area_entered",self,"on_area_entered")
	print(player.keys)
	
func on_area_entered(area2d):
	player.keys.append(self.name)
	print(player.keys)
	queue_free()
