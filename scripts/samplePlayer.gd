extends Node2D

var choord_num = 0;

var choords : Array[Array] = [
	[["C", 4], ["E", 4], ["G", 4]],
	[["C", 4], ["E", 4], ["G", 4]],
	[["G", 4]],
	[["E", 4]],
	[["G", 4], ["B", 4], ["D", 5]],
	[["G", 4], ["B", 4], ["D", 5]],
	[["D", 5]],
	[["B", 4]],
	[["B", 4]],
	[["A", 4], ["C", 5], ["E", 5]],
	[["A", 4], ["C", 5], ["E", 5]],
	[["E", 5]],
	[["C", 5]],
	[["F", 4], ["A", 4], ["C", 5]],
	[["F", 4], ["A", 4], ["C", 5]],
	[["C", 5]],
	[["A", 4]],
	[["D", 4]],
]
var timer = 0.0;

func _ready():
	Globals.playNote.connect(playChoord)
func playChoord():
	$SamplerInstrument.release()
	var str = "playing: ";
	for note in choords[choord_num]:
		str += (note[0] + str(note[1]) + " ")
		$SamplerInstrument.play_note(note[0], note[1])  
	print(str)
	choord_num = (choord_num + 1)%choords.size()
	pass

func _process(delta: float) -> void:
	pass
