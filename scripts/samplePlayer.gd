extends Node2D

var choord_num = 0;

var choords : Array[Array] = [
	[["C", 3], ["E", 3], ["G", 3]],
	[["C", 3], ["E", 3], ["G", 3]],
	[["G", 3]],
	[["E", 3]],
	[["G", 3], ["B", 3], ["D", 4]],
	[["G", 3], ["B", 3], ["D", 4]],
	[["D", 4]],
	[["B", 3]],
	[["B", 3]],
	[["A", 3], ["C", 4], ["E", 4]],
	[["A", 3], ["C", 4], ["E", 4]],
	[["E", 4]],
	[["C", 4]],
	[["F", 3], ["A", 3], ["C", 4]],
	[["F", 3], ["A", 3], ["C", 4]],
	[["C", 4]],
	[["A", 3]],
	[["D", 3]],
]
var choords_synth : Array[Array] = [
	[["C", 2]],
	[["C", 2]],
	[["C", 2]],
	[["C", 2]],
	[["G", 2]],
	[["G", 2]],
	[["G", 2]],
	[["G", 2]],
	[["G", 2]],
	[["A", 2]],
	[["A", 2]],
	[["A", 2]],
	[["A", 2]],
	[["F", 3]],
	[["F", 3]],
	[["F", 3]],
	[["F", 3]],
	[["F", 3]],
]
#var choords : Array[Array] = [
	#[["B", 4], ["G#", 4], ["D#", 4], ["G#", 2]],
	#[["B", 4], ["G#", 4], ["D#", 4], ["G#", 2]],
	#[["G#", 2]],
	#[["G#", 4]],
	#[["A#", 4], ["F#", 4], ["C#", 4], ["F#", 2]],
	#[["A#", 4], ["F#", 4], ["C#", 4], ["F#", 2]],
	#[["E", 4], ["C#", 4], ["A", 3], ["A", 2]],
	#[["E", 4], ["C#", 4], ["A", 3], ["A", 2]],
	#[["A#", 4], ["F#", 4], ["D#", 4], ["D#", 2]],
	#[["A#", 4], ["F#", 4], ["D#", 4], ["D#", 2]],
#
#]
var timer = 0.0;

func _ready():
	Globals.playNote.connect(playChoord)
	Globals.playDrums.connect(playDrum)
	Globals.playSynth.connect(playSynth)
func playChoord():
	$Keys.release()
	var str = "(keys) playing: ";
	for note in choords[choord_num]:
		str += (note[0] + str(note[1]) + " ")
		$Keys.play_note(note[0], note[1])  
	print(str)
	choord_num = (choord_num + 1)%choords.size()
	pass
func playDrum():
	$Drums.play_note("C", 4)
func playSynth():
	$Synth.release()
	var str = "(synth) playing: ";
	for note in choords_synth[choord_num]:
		str += (note[0] + str(note[1]) + " ")
		$Synth.play_note(note[0], note[1])  
func _process(delta: float) -> void:
	pass
