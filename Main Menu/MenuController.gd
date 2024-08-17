extends Node

@onready var textbox = $"Textbox Layer/Textbox Area"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	$"Menu Layer".visible = false
	textbox.display_text([
		{name = "luna", dialogue = "it works! Now let me test some of this delay stuff! Hello? this works, I think."},
		{name = "jack", dialogue = "its cool"},
	])

func _on_quit_pressed():
	get_tree().quit()
