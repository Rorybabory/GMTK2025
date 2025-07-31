extends Node2D

var choord_num = 0;

var choords : Array[Array] = [
	[["C", 4], ["E", 4], ["G", 4]],
	[["G", 4], ["B", 4], ["D", 5]],
	[["A", 4], ["C", 5], ["E", 5]],
	[["F", 4], ["A", 4], ["C", 5]]
]
var timer = 0.0;

func _ready():
	pass
func playChoord():
	$SamplerInstrument.release()
	var str = "playing: ";
	for note in choords[choord_num]:
		str += (note[0] + str(note[1]) + " ")
		$SamplerInstrument.play_note(note[0], note[1])  
	print(str)
	pass
func _process(delta: float) -> void:
	timer += delta
	if (timer > 1.5):
		playChoord()
		choord_num+=1
		if (choord_num > 3):
			choord_num = 0
		timer = 0

	pass
