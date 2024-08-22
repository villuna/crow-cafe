extends Node

var food_done := false
var food_overcooked := false
@onready var food_timer: Timer = $"Food Timer"
@onready var fail_timer: Timer = $"Fail Timer"
@onready var result: Label = $Result
@onready var hand: Hand = $Hand
@onready var food_sprite: AnimatedSprite2D = $Food
@onready var ding: Label = $Ding

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	food_timer.start(randf_range(3, 7))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func display_result(message: String) -> void:
	result.visible = true
	result.text = message
	hand.stop_moving()
	food_timer.stop()
	fail_timer.stop()
	# TODO: display open oven door
	food_sprite.pause()

func _on_button_pressed() -> void:
	if not food_done:
		display_result("Too fast!")
	else:
		if not food_overcooked:
			display_result("Yummy!")


func _on_food_timer_timeout() -> void:
	food_done = true
	ding.visible = true
	fail_timer.start(1)

func _on_fail_timer_timeout() -> void:
	food_overcooked = true
	display_result("Overcooked!!!!")
