extends CharacterBody2D
class_name EnemyShoot
var player : Player = null
var accel : float = 200.0
var max_vel : float = 30.0

var state : String = "chase"
var stateTimer : float = 0.0
var speedMod : float = 1.0
var shootTimer : float = 0.0

var projScene : PackedScene = load("res://prefabs/projectile_enemy.tscn")
func _ready():
	Globals.numEnemies+=1
	speedMod = randf_range(0.7, 1.2)
	shootTimer = randf_range(0.0, 1.5)

func fireProjectile():
	var proj = projScene.instantiate()
	get_node("../").add_child(proj)
	proj.global_position = global_position + transform.x * 16.0
	proj.rotation = rotation

func _process(delta: float) -> void:
	#find player
	if (player == null):
		player = get_node("../../../Player")
		return
		
	var myPos = global_position;
	var playerPos = player.global_position
	var dir = (playerPos-myPos).normalized()
	var rot = dir.angle()
	
	if (state == "chase"):
		rotation = rot
		velocity += dir * delta * accel;
		shootTimer += delta
		if (shootTimer > 2.0):
			fireProjectile()
			shootTimer = 0.0
	elif (state == "flee"):
		rotation = rot
		velocity += -dir * delta * accel;
		stateTimer+=delta
		if (stateTimer > 3.0):
			stateTimer = 0.0
			state = "chase"
	
	
	if (velocity.length() > max_vel * speedMod):
		velocity = velocity.normalized() * max_vel * speedMod
	move_and_slide()
	pass
 
