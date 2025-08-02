extends Node2D

var player : Player = null

func _ready():
	
	pass

func _process(delta: float) -> void:
	if (player == null):
		player = get_node("../Player")
		
	global_position = player.global_position + Vector2(0.0, -24.0)
	$bar.size.x = 8 * Globals.player_health
	pass
