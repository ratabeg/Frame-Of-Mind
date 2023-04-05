
# Mingpei Dou, Raouf Atabeg, Jordi Cochegrus, Adam Salamayeh, Ishaan Kumar
# CS4483 Katchabaw
# 2 Mar 2023

extends Node2D

func _ready():
	$Area2D.connect("area_entered",self,"on_area_entered")
	$AnimationPlayer.play("idle")
	
func on_area_entered(area2d):
	$AnimationPlayer.play("pickup")
	call_deferred("disable_pickup()")


func disable_pickup():
	$Area2D/CollisionShape2D.disabled = true	
	
