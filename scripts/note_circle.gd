extends Sprite2D

var index = 0
var timer = 0.0
var circles : Array[CompressedTexture2D] = [
	load("res://sprites/note_circle.png"),
	load("res://sprites/note_circle2.png"),
	load("res://sprites/note_circle3.png")
]

func _ready():
	pass
func _process(delta: float) -> void:
	texture = circles[index]
	timer += delta
	if (timer > 0.2):
		timer = 0.0
		index+=1
		if (index >= circles.size()):
			index = 0
	pass
