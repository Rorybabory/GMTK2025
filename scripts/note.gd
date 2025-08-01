extends Node2D
class_name Note
var active : bool = false
var pos : Vector2 = Vector2(0.0,0.0)
var playing : bool = false;

func _ready():
	pass

func _process(delta: float) -> void:
	if (active):
		global_position.x -= delta * Globals.speed
	pass
	if (global_position.x < -128):
		queue_free()
	if (global_position.x < 64.0 and global_position.x > 64.0-$bkg.size.x):
		if not playing:
			playing = true;
			Globals.playNote.emit()
		$main.hide()
	else:
		$main.show()
	if (not active):
		var mouse_pos : Vector2 = get_global_mouse_position()
		if (global_position.x < mouse_pos.x and
			global_position.y < mouse_pos.y and
			global_position.x + $bkg.size.x > mouse_pos.x and 
			global_position.y + $bkg.size.y > mouse_pos.y):
			if (Input.is_action_just_pressed("right_click")):
				queue_free()
		
