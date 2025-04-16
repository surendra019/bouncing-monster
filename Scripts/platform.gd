extends StaticBody2D

@onready var panel: ColorRect = $Panel
@export var active_color: Color
@onready var destroy_timer: Timer = $Timer
@onready var crack: TextureRect = $Panel/TextureRect

@export var theme_jungle: Color
@export var theme_white: Color
@export var theme_space: Color
@export var theme_water: Color


var shake_amount := 10.0  # Maximum distance to shake
var shake_duration := 0.5  # Total duration of the shake in seconds
var shake_timer := 0.0

var original_position := Vector2.ZERO

enum STATE {DEACTIVE, ACTIVE}
var state: STATE


func _ready() -> void:
	original_position = position
	
	crack.modulate.a = 0.0
	match Manager.current_theme:
		Manager.THEME.WHITE:
			active_color = theme_white
		Manager.THEME.JUNGLE:
			active_color = theme_jungle
		Manager.THEME.SPACE:
			active_color = theme_space
		Manager.THEME.WATER:
			active_color = theme_water
func set_state(state: STATE) -> void:
	self.state = state
	match self.state:
		STATE.ACTIVE:
			panel.color = active_color
			if Manager.current_mode != Manager.MODE.EASY:
				destroy_timer.wait_time = randf_range(2, 3)
				destroy_timer.start()
				
func _on_timer_timeout() -> void:
	var t = create_tween()
	t.tween_property(crack, "modulate:a", 1.0, .8)
	t.play()
	start_shake(.15, .8)
	t.tween_callback(func():
		get_tree().get_first_node_in_group("main").spawn_platform_destroy_particle(global_position)
		queue_free()
		)
		
func _process(delta):
	if shake_timer > 0:
		shake_timer -= delta
		var offset = Vector2(
			randf_range(-shake_amount, shake_amount),
			randf_range(-shake_amount, shake_amount)
		)
		position = original_position + offset
	else:
		position = original_position

func start_shake(duration := 0.5, amount := 10.0):
	shake_duration = duration
	shake_amount = amount
	shake_timer = duration
