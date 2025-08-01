extends Node2D
@export var notes : Node2D
var noteScene : PackedScene = load("res://prefabs/note.tscn")
var timer : float = 0.0;
var loopNum : int = 0
func _ready():
	pass
func spawnNote():
	for note in notes.get_children():
		var newNote = noteScene.instantiate()
		get_node("../Loops").add_child(newNote)
		newNote.active = true
		newNote.global_position = global_position + note.pos
	
func _process(delta: float) -> void:
	timer += delta
	if (timer > Globals.noteSpawnRate):
		spawnNote()
		timer = 0.0
