extends CharacterBody2D

var accel : float = 200.0
var projScene : PackedScene = preload("res://prefabs/projectile.tscn")

func _ready():
	Globals.playNote.connect(spawnProjectile)
func spawnProjectile():
	var proj = projScene.instantiate()
	get_node("../").add_child(proj)
	proj.global_position = global_position + transform.x * 32.0
	proj.rotation = rotation
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if (Input.is_action_pressed("player_forward")):
		velocity += delta * transform.x * accel
	else:
		velocity = velocity.lerp(Vector2(0.0, 0.0), delta * 2.0)
	move_and_slide()
	
