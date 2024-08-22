extends Node

@onready var dialogue_box: DialogueBox = $"DialogueBox Layer/DialogueBox"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	$"Menu Layer".visible = false
	dialogue_box.display_text([
		{
			name = "corey",
			dialogue = "hey, you must be the new guy i heard about.",
			text_color = Color(0.5, 0.5, 0.5)
		},
		{ dialogue = "i've been the only barista here for a while, so i'm up to my beak in work. it'll be nice to have an extra pair of wings on deck." },
		{ dialogue = "listen, we open in a couple minutes. we'll need to get working now if we don't wanna fall behind." },
		{ dialogue = "sorry to throw you out of the nest like this, but there's no time for training. you'll have to learn to fly on your own." },
		{ dialogue = "hm? you don't know what you're supposed to be doing?" },
		{ dialogue = "why, you'll be playing *microwgames* of course." },
		{ dialogue = "good luck!", event = "start game" }
	])

func _on_quit_pressed() -> void:
	get_tree().quit()

func start_game() -> void:
	get_tree().change_scene_to_file("res://Button Game/button_game.tscn")

func _on_textbox_area_dialogue_event(event_name: String) -> void:
	if event_name == "start game":
		start_game()
