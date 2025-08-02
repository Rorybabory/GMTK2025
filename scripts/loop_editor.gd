extends Node2D

var noteScene : PackedScene = load("res://prefabs/note.tscn")

func _ready():
	pass

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("click") and Globals.freeNotes > 0):
		var mouse_pos = get_global_mouse_position()
		var mouse_bounded = get_global_mouse_position() - global_position;
		if (mouse_bounded.x > 256 or mouse_bounded.x < 0 or 
			mouse_bounded.y > 112 or mouse_bounded.y < 0):
			return
		mouse_pos.x = floor(mouse_pos.x/16.0)*16.0;
		mouse_pos.y = floor(mouse_pos.y/16.0)*16.0+1.0;
		var type = int((mouse_pos.y - global_position.y)/16)
		if (type > 1):
			return
		#create a note
		var inst : Note = noteScene.instantiate()
		get_node("Notes").add_child(inst)
		inst.global_position = mouse_pos
		inst.active = false;
		inst.pos = mouse_pos - global_position
		inst.type = type
		Globals.freeNotes-=1
