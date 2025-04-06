extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

@onready var camera: Camera2D = $Camera2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
const DEAD = preload("res://Assets/Individual/dead.png")

const JUMP_VELOCITY = -950.0
var main_ref

var time_scale_tween: Tween
var current_rotator: Node2D

func _ready() -> void:
	main_ref = get_tree().get_first_node_in_group("main")
	camera.global_position = global_position
	get_tree().get_first_node_in_group("input").gui_input.connect(func(event):
		if event is InputEventScreenTouch:
			if event.pressed:
				if is_on_floor():
					velocity.y = JUMP_VELOCITY
				check_next_an_play_time_scale()
		)
		
func _physics_process(delta: float) -> void:
	if not main_ref.paused:
		if not main_ref.game_over:
			camera.global_position.y = lerp(camera.global_position.y, global_position.y, delta * 5)
			camera.global_position.x = lerp(camera.global_position.x, global_position.x, delta * 5)
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("platform"):
		if body.state != body.STATE.ACTIVE:
			body.set_state(body.STATE.ACTIVE)
	elif body.is_in_group("rotator"):
		print("called")
		if collision_mask != 0b00000010:
			camera.start_shake()
			set_mask_layer_2()
			#velocity.y = -JUMP_VELOCITY / 4
			main_ref.set_game_over(global_position)
			sprite.texture = DEAD


func disable_collision(a: bool) -> void:
	collision_shape_2d.disabled = a


# Enable only mask layer 2 (disable others)
func set_mask_layer_2():
	collision_mask = 0b00000010  # Binary: Only layer 2 is enabled (bit 2)

# Enable only mask layer 1 (disable others)
func set_mask_layer_1():
	collision_mask = 0b00000001  # Binary: Only layer 1 is enabled (bit 1)

# checks if the next rotator is moving, if yes then plays the time scale.
func check_next_an_play_time_scale() -> void:
	if main_ref:
		if main_ref.get_next_rotator().can_start:
			play_time_scale_effect()
			
func play_time_scale_effect() -> void:
	if not main_ref.game_over:
		Engine.time_scale = .1
		time_scale_tween = create_tween()
		time_scale_tween.tween_property(Engine, "time_scale", 1, 1)
		time_scale_tween.play()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("rotator"):
		if collision_mask != 0b00000010:
			camera.start_shake()
			set_mask_layer_2()
			#velocity.y = -JUMP_VELOCITY / 4
			main_ref.set_game_over(global_position)
			sprite.texture = DEAD
