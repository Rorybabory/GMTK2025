extends Node2D

@export var enemies : Array[PackedScene]

func _ready():
	pass

func spawnWave():
	
	for point in $SpawnPoints.get_children():
		var pos = point.global_position
		var enemyID = 0
		if (randi_range(0, 10) < Globals.waveNumber):
			enemyID = 1
		var inst : Node2D = enemies[enemyID].instantiate()
		$Enemies.add_child(inst)
		inst.global_position = pos
func reloadScene():
	Globals.freeNotes = 0
	Globals.waveNumber = 0
	Globals.player_health = 8
	get_tree().reload_current_scene()
	
func _process(delta: float) -> void:
	if (Globals.player_health <= 0):
		reloadScene()
		return
	if get_tree().get_nodes_in_group("Enemy").size() == 0:
		Globals.freeNotes+=1
		spawnWave()
		Globals.waveNumber+=1
		Globals.player_health+=2
		if (Globals.player_health > 8):
			Globals.player_health = 8
