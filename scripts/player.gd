extends CharacterBody2D
class_name Player

var accel : float = 200.0
var max_vel : float = 200.0
var projScene : PackedScene = preload("res://prefabs/projectile.tscn")

var drumCircleSize : float = 0.0;

func _ready():
	Globals.playNote.connect(spawnProjectile)
	Globals.playDrums.connect(drumAttack)
	Globals.playerDamage.connect(takeDamage)
func spawnProjectile():
	var proj = projScene.instantiate()
	get_node("../").add_child(proj)
	proj.global_position = global_position + transform.x * 16.0
	proj.rotation = rotation
func drumAttack():
	drumCircleSize = 0.75;
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if (global_position.distance_to(enemy.global_position) < 192):
			enemy.queue_free()
func takeDamage():
	Globals.player_health-=1
	pass
func _process(delta: float) -> void:
	drumCircleSize = lerpf(drumCircleSize, 0.0, delta * 5.0)
	$drumCircle.scale.x = drumCircleSize;
	$drumCircle.scale.y = drumCircleSize;
	
	look_at(get_global_mouse_position())
	velocity.x += delta * Input.get_axis("left", "right") * accel
	velocity.y += delta * Input.get_axis("up", "down") * accel
	if (not(Input.is_action_pressed("left") or Input.is_action_pressed("right"))):
		velocity.x = lerpf(velocity.x, 0.0, delta * 0.5)
	if (not(Input.is_action_pressed("up") or Input.is_action_pressed("down"))):
		velocity.y = lerpf(velocity.y, 0.0, delta * 0.5)
	if (velocity.length() > max_vel):
		velocity = velocity.normalized() * max_vel
	move_and_slide()
	
