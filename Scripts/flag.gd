
# Mingpei Dou, Raouf Atabeg, Jordi Cochegrus, Adam Salamayeh, Ishaan Kumar
# CS4483 Katchabaw
# 2 Mar 2023

# flag class, stores functionality for flag
extends Node2D



var inArea = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Area2D_body_entered(body: KinematicBody2D):
	inArea = true
	print(body)
	
	## Code snippet from BookMonster from individual prototype submitted by Ishaan Kumar
func _physics_process(delta):
	if inArea: 
		get_tree().change_scene("res://Scenes/level2.tscn")
