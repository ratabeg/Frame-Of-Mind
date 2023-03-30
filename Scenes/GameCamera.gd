extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var targetposition = Vector2.ZERO

export(Color,RGB) var backgroundColor
# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(backgroundColor)
	pass # Replace with function body.

func aquire_target_position():
	var players = get_tree().get_nodes_in_group("player")
	if(players.size() > 0 ):
		var player = players[0]
		global_position = player.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	aquire_target_position()
	
	global_position = lerp(targetposition,global_position, pow(2,-25 *delta))
	
#	pass
