extends KinematicBody2D


# Declare member variables here. Examples:
var gravity = 1000
var velocity = Vector2.ZERO
var maxHorizontalSpeed = 125
var jumpspeed = 360
var horizontalAceleration = 1500
var jumpterminationmultipler = 4
var hasDoubleJump = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$HazardArea.connect("area_entered",self,"on_hazard_area_enter")
	pass # Replace with function body.

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
	
	#horizintol movement left and right 
	#velocity.x = moveVector.x * maxHorizontalSpeed
	velocity.x += moveVector.x * horizontalAceleration * delta
	if(moveVector.x == 0):
		#velocity.x = lerp(velocity.x,0,.1)
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
#	pass

func on_hazard_area_enter(area2d):
	print("died")
