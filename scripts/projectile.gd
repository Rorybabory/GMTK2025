extends Node2D

var timer : float = 0.0

var speed : float = 500.0
var explodePrefab : PackedScene = load("res://prefabs/explode.tscn")
func _ready():
	pass

func _process(delta: float) -> void:
	global_position += transform.x * speed * delta
	timer += delta
	if (timer > 3.0):
		queue_free()
	pass


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Enemy")):
		body.queue_free()
		Globals.numEnemies-=1
		var inst = explodePrefab.instantiate()
		get_node("../").add_child(inst)
		inst.global_position = global_position
		var expScale = randf_range(0.05, 0.15)
		inst.scale = Vector2(expScale,expScale)
		inst.rotation = randf_range(0.0, PI*2.0)
