extends Node2D
class_name Note

enum NoteType {PIANO, DRUM, SYNTH}

var active : bool = false
var pos : Vector2 = Vector2(0.0,0.0)
var playing : bool = false;
var distance : float = 10000.0
var color : Color = Color.BLACK
@export var type : NoteType = NoteType.SYNTH

var colors : Array[Array] = [
	#PIANO
	[ 
		Color.html("#684127"),
		Color.html("#ad6f40")
	],
	#DRUM
	[ 
		Color.html("#305636"),
		Color.html("#5e8f4a")
	],
	#SYNTH
	[ 
		Color.html("#265264"),
		Color.html("#308ea1")
	],
]

func _ready():
	pass

func _process(delta: float) -> void:
	if (type > 2):
		type = 0
	distance = global_position.x - 64.0
	$bkg.modulate = colors[type][1]
	color = colors[type][1]
	if (active):
		global_position.x -= delta * Globals.speed
	pass
	if (global_position.x < -128):
		queue_free()
	if (global_position.x < 64.0 and global_position.x > 64.0-$bkg.size.x):
		if not playing:
			playing = true;
			if (type == NoteType.PIANO):
				Globals.playNote.emit()
			elif (type == NoteType.DRUM):
				Globals.playDrums.emit()
			elif (type == NoteType.SYNTH):
				Globals.playSynth.emit()
		$solid.show()
	else:
		$solid.hide()
	if (not active):
		var mouse_pos : Vector2 = get_global_mouse_position()
		if (global_position.x < mouse_pos.x and
			global_position.y < mouse_pos.y and
			global_position.x + $bkg.size.x > mouse_pos.x and 
			global_position.y + $bkg.size.y > mouse_pos.y):
			if (Input.is_action_just_pressed("right_click")):
				Globals.freeNotes+=1
				queue_free()
		
