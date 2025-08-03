extends CharacterBody2D
class_name Player

var accel : float = 200.0
var max_vel : float = 200.0
var projScene : PackedScene = preload("res://prefabs/projectile.tscn")
var hitLinesTimer : float = 0.0
var showHitLines : bool = false
var drumCircleSize : float = 0.0;

func _ready():
	Globals.playNote.connect(spawnProjectile)
	Globals.playDrums.connect(drumAttack)
	Globals.playSynth.connect(synthAttack)
	Globals.playerDamage.connect(takeDamage)
func spawnProjectile():
	showHitLines = true
	var proj = projScene.instantiate()
	get_node("../").add_child(proj)
	proj.global_position = global_position + transform.x * 16.0
	proj.rotation = rotation
func synthAttack():
	showHitLines = true
	for i in range(-7, 7):
		var proj = projScene.instantiate()
		get_node("../").add_child(proj)
		proj.global_position = global_position + transform.x * 16.0
		proj.rotation = rotation + float(i) * (PI/180.0) * 2.0
	
func drumAttack():
	showHitLines = true
	drumCircleSize = 0.75;
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if (global_position.distance_to(enemy.global_position) < 192):
			enemy.queue_free()
func updateNoteCircle(delta):
	var closestNote : Note = null
	var closestDist = 256.0
	for note in get_tree().get_nodes_in_group("Note"):
		var noteCast : Note = note
		if (noteCast == null):
			print("invalid note")
			return
		if (noteCast.distance < closestDist and noteCast.distance > 0.0):
			closestDist = noteCast.distance
			closestNote = noteCast
	var circle = $noteCircleKeys
	var scaleMod = 0.5
	if (closestNote == null):
		$noteCircleKeys.scale = $noteCircleKeys.scale.lerp(Vector2.ZERO, delta*8.0) 
		$noteCircleDrum.scale = $noteCircleDrum.scale.lerp(Vector2.ZERO, delta*8.0) 
		return
	if (closestNote.type == 1):
		circle = $noteCircleDrum
		scaleMod = 3.0
	circle.modulate = closestNote.color
	circle.scale = circle.scale.lerp(Vector2(closestNote.distance, closestNote.distance)/256.0 * scaleMod, delta*8.0) 
func takeDamage():
	Globals.player_health-=1
	pass
func _process(delta: float) -> void:
	if (showHitLines):
		$hitLines.show()
	else:
		$hitLines.hide()
	if (showHitLines):
		hitLinesTimer += delta
		if (hitLinesTimer > 0.2):
			hitLinesTimer = 0.0
			showHitLines = false
	drumCircleSize = lerpf(drumCircleSize, 0.0, delta * 5.0)
	$drumCircle.scale.x = drumCircleSize;
	$drumCircle.scale.y = drumCircleSize;
	updateNoteCircle(delta)
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
	
