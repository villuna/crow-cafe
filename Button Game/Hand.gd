class_name Hand
extends Sprite2D

var moving := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and moving:
		position += event.relative
		position.x = clamp(position.x, -250, 1050)
		position.y = clamp(position.y, 0, 720)

func stop_moving() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	moving = false
