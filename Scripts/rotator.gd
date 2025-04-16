extends StaticBody2D

@export var speed: int = 3
@export var direction: int = 1

@export var can_start: bool = false

@export var theme_jungle: CompressedTexture2D
@export var theme_white: CompressedTexture2D
@export var theme_space: CompressedTexture2D
@export var theme_water: CompressedTexture2D

var box_r
var box_l
var player_entered: bool
var main_ref
var is_big: bool = true
var small_rotator
var hide_timer: Timer
var show_timer: Timer

func _ready() -> void:
	if Manager.current_theme == Manager.THEME.JUNGLE:
		get_child(0).texture = theme_jungle
	elif Manager.current_theme == Manager.THEME.WHITE:
		get_child(0).texture = theme_white
	elif Manager.current_theme == Manager.THEME.SPACE:
		get_child(0).texture = theme_space
	elif Manager.current_theme == Manager.THEME.WATER:
		get_child(0).texture = theme_water
		
		
		
	main_ref = get_tree().get_first_node_in_group("main")
	if Manager.current_mode == Manager.MODE.HARD:
		hide_timer = Timer.new()
		add_child(hide_timer)
		hide_timer.one_shot = true
		
		show_timer = Timer.new()
		add_child(show_timer)
		show_timer.one_shot = true
		hide_timer.timeout.connect(func():
			if not player_entered:
				var pro = [true, false].pick_random()
				if pro:
					show_timer.wait_time = randf_range(3, 4)
					show_timer.start()
					hide()
					if small_rotator:
						small_rotator.hide()
			)
		show_timer.timeout.connect(func():
			show()
			if small_rotator:
				small_rotator.show()
			)

func start_hide_timer() -> void:
	hide_timer.wait_time = randf_range(1, 3)
	hide_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main_ref:
		if not main_ref.paused:
			if can_start:
				rotation += speed * delta * direction
	else:
		if can_start:
			rotation += speed * delta * direction


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and ((box_l and box_r) || not is_big):
		can_start = true
		player_entered = true
		show()
		if small_rotator:
			small_rotator.show()
		if is_big:
			body.current_rotator = self
			box_r.tween(box_r.global_position - Vector2(230, 0))
			box_l.tween(box_l.global_position + Vector2(230, 0))
		get_tree().get_first_node_in_group("main").increase_score(1)
		if Manager.current_mode == Manager.MODE.HARD:
			main_ref.start_next_rotator_hide_timer()
