extends Control

# Whether we are displaying dialogue right now
var displaying: bool = false
# All the text in the current dialogue line
var dialogue_lines: Array = []
# The index of the line of dialogue to display 
var index: int = 0
# How many characters in the string to display
var char_index: int = 0

@onready var char_timer = $"TextBox/Char Timer"
@onready var name_label = $TextBox/Name
@onready var dialogue_label = $TextBox/Dialogue
@onready var sprite = $CharacterSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_text(lines: Array):
	dialogue_lines = lines
	index = 0
	char_index = 1
	visible = true
	displaying = true
	set_box_text()
	char_timer.start(delay_for_char(lines[index].dialogue.substr(0, 1)))

# Proceeds the text to the next checkpoint.
func proceed_text():
	pass

func set_box_text():
	dialogue_label.text = dialogue_lines[index].dialogue.substr(0, char_index)
	name_label.text = dialogue_lines[index].name

func delay_for_char(c: String) -> float:
	if c == "." || c == "!" || c == "?":
		return 0.3
	elif c == ",":
		return 0.1
	else:
		return 0.03

func _on_char_timer_timeout():
	if displaying and dialogue_lines.size() > index:
		var dialogue_str: String = dialogue_lines[index].dialogue
		if char_index < dialogue_str.length():
			var next_delay = delay_for_char(dialogue_str.substr(char_index - 1, 1))
			char_index += 1
			set_box_text()
			char_timer.start(next_delay)
