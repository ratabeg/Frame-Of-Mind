
# Mingpei Dou, Raouf Atabeg, Jordi Cochegrus, Adam Salamayeh, Ishaan Kumar
# CS4483 Katchabaw
# 2 Mar 2023

extends KinematicBody2D


# Declare member variables here. 
var gravity = 1000
var velocity = Vector2.ZERO
var maxHorizontalSpeed = 125
var jumpspeed = 360
var horizontalAceleration = 1500
var jumpterminationmultipler = 4
var hasDoubleJump = false
var keys = []

# camera var
var swapCam = false
onready var cam1 = $CameraAnchor1
onready var cam2 = $CameraAnchor2


# Called when the node enters the scene tree for the first time.
func _ready():
	$HazardArea.connect("area_entered",self,"on_hazard_area_enter")

func get_movement_vector():
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	moveVector.y = -1 if Input.is_action_just_pressed("jump") else 0
	return moveVector
	
	
func update_animation():
	var moveVec = get_movement_vector()
	
	if(!is_on_floor()):
		$AnimatedSprite.play("jump")
	elif(moveVec.x != 0 ):
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
		
	if (moveVec.x != 0 ):
		$AnimatedSprite.flip_h = true if moveVec.x > 0  else false
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	#get the input key methods
	var moveVector = get_movement_vector()
	swapCam() # this game sucks
	
	velocity.x += moveVector.x * horizontalAceleration * delta
	if(moveVector.x == 0):
		velocity.x = lerp(0,velocity.x, pow(2,-25 *delta))
		
	velocity.x = clamp(velocity.x,-maxHorizontalSpeed,maxHorizontalSpeed)
	
	
	#gravity check for jumping of character
	if(moveVector.y < 0 && (is_on_floor() || !$CoyoteTimer.is_stopped() || hasDoubleJump) ):
		velocity.y += moveVector.y * jumpspeed
		if(!is_on_floor() && $CoyoteTimer.is_stopped()):
			hasDoubleJump = false
		$CoyoteTimer.stop()
			

	if(velocity.y < 0 && !Input.is_action_pressed("jump")):
		velocity.y += gravity * jumpterminationmultipler * delta
	else: 
		velocity.y += gravity * delta

	#go to the flag when perspective has changed 
	if(Input.is_action_pressed("perspective")):
		print("perspective")
		

	var wasOnFloor = is_on_floor()
	#velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	
	if(wasOnFloor && !is_on_floor()):
		$CoyoteTimer.start()
	if(is_on_floor()):
		hasDoubleJump = true
	
	update_animation()
	
	if Input.is_action_pressed("ui_end"):
		get_tree().change_scene("res://Scenes/Menu.tscn")
# handle camera switching
func swapCam():
	if Input.is_action_just_pressed("perspective"):
		swapCam = !swapCam

# collision detection methods (Depricated from Flower-Charged):
# handles player collision
func on_hazard_area_enter(area2d):
	if area2d.is_in_group("killPlayer"):
		kill() # call kill command
	if area2d.is_in_group("movePlayer") and len(keys)!=0:
		move_local_x(-380)
		move_local_y(-100)

# handle kill visuals
func kill():
	$Sprite.modulate = Color("ff5252") # visualize damage
	get_tree().reload_current_scene() # kills player
	#$DamageTimer.start()

# reset damage animation
func _on_DamageTimer_timeout():
	print("Kill")
	$Sprite.modulate = Color("ffffff") # reset damage
