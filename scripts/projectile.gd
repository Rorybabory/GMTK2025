extends Node2D

var timer : float = 0.0

var speed : float = 500.0

func _ready():
	pass

func _process(delta: float) -> void:
	global_position += transform.x * speed * delta
	timer += delta
	if (timer > 3.0):
		queue_free()
	pass
