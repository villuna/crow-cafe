extends AnimatedSprite2D
signal pressed
var has_been_pressed := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	frame = 1
	
	if not has_been_pressed:
		pressed.emit()
		has_been_pressed = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	frame = 0
