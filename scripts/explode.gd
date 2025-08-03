extends Sprite2D

var index = 0
var timer = 0.0
var tex : Array[CompressedTexture2D] = [
	load("res://sprites/explode1.png"),
	load("res://sprites/explode2.png"),
	load("res://sprites/explode3.png"),
]
var times : Array[float] = [
	0.05,
	0.1,
	0.2
]

func _ready():
	pass
func _process(delta: float) -> void:
	texture = tex[index]
	timer += delta
	if (timer > times[index]):
		timer = 0.0
		index+=1
		if (index >= tex.size()):
			queue_free()
	pass
