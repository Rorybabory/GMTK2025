extends RichTextLabel

func _ready():
	pass

func _process(delta: float) -> void:
	text = "Notes: " + str(Globals.freeNotes)
