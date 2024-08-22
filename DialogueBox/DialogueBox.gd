class_name DialogueBox
extends Control

signal dialogue_event(event_name: String)

# Whether we are displaying dialogue right now
var displaying := false
# All the text in the current dialogue line
var dialogue_lines: Array[Dictionary] = []
# The index of the line of dialogue to display 
var index := 0
# How many characters in the string to display
var char_index := 0

@onready var char_timer: Timer = $"TextBox/Char Timer"
@onready var name_label: Label = $TextBox/Name
@onready var dialogue_label: Label = $TextBox/Dialogue
@onready var sprite: Sprite2D = $CharacterSprite
@onready var down_arrow: Sprite2D = $"TextBox/Down Arrow"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if displaying and Input.is_action_just_pressed("ui_accept"):
		proceed_text()

func start_new_line(i: int) -> void:
	index = i
	char_index = 1
	down_arrow.visible = false
	set_box_text()
	char_timer.start(delay_for_char(dialogue_lines[index].dialogue.substr(0, 1)))

func display_text(lines: Array[Dictionary]) -> void:
	dialogue_lines = lines
	index = 0
	char_index = 1
	visible = true
	displaying = true
	down_arrow.visible = false
	set_box_text()
	char_timer.start(delay_for_char(lines[index].dialogue.substr(0, 1)))

func stop_displaying() -> void:
	visible = false
	displaying = false
	dialogue_lines = []
	index = 0
	char_index = 0

# Proceeds the text to the next checkpoint.
func proceed_text() -> void:
	if line_fully_displayed():
		var event: Variant = dialogue_lines[index].get("event")
		if event != null:
			dialogue_event.emit(event)
			
		if index == dialogue_lines.size() - 1:
			stop_displaying()
		else:
			start_new_line(index + 1)
	else:
		char_index = dialogue_lines[index].dialogue.length()
		char_timer.stop()
		set_box_text()
	
func line_fully_displayed() -> bool:
	return displaying && dialogue_lines[index].dialogue.length() == char_index

func set_box_text() -> void:
	dialogue_label.text = dialogue_lines[index].dialogue.substr(0, char_index)
	var maybe_name: Variant = dialogue_lines[index].get("name")
	if maybe_name != null:
		name_label.text = maybe_name
		
	var maybe_color: Variant = dialogue_lines[index].get("text_color")
	if maybe_color != null:
		name_label.add_theme_color_override("font_color", maybe_color)
	
	# Set the down arrow to be visible if the line is fully displayed
	if line_fully_displayed():
		if not down_arrow.visible:
			$"TextBox/Down Arrow/AnimationPlayer".play("Move")
			down_arrow.visible = true

func delay_for_char(c: String) -> float:
	if c == "." || c == "!" || c == "?":
		return 0.3
	elif c == ",":
		return 0.1
	else:
		return 0.03

func _on_char_timer_timeout() -> void:
	if displaying and dialogue_lines.size() > index:
		var dialogue_str: String = dialogue_lines[index].dialogue
		if char_index < dialogue_str.length():
			var next_delay := delay_for_char(dialogue_str.substr(char_index - 1, 1))
			char_index += 1
			set_box_text()
			char_timer.start(next_delay)
