extends CharacterBody2D
class_name Enemy
var player : Player = null
var accel : float = 200.0
var max_vel : float = 100.0

var state : String = "chase"
var stateTimer : float = 0.0
var speedMod : float = 1.0
func _ready():
	Globals.numEnemies+=1
	speedMod = randf_range(0.7, 1.2)

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
 


func _on_hitbox_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player") and state == "chase"):
		state = "flee"
		stateTimer = 0.0
		Globals.playerDamage.emit()
