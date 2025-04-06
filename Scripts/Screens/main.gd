extends Control

@onready var rotator_spawn_point_x: Marker2D = $RotatorSpawn
@onready var rotator_container: Node2D = $RotatorContainer
@onready var rotator_spawn_point_y: Marker2D = $RotatorStart
@onready var platform_container: Node2D = $PlatformContainer
@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var box_spawn_right_x: Marker2D = $BoxSpawnRightX
@onready var box_spawn_left_x: Marker2D = $BoxSpawnLeftX
@onready var box_container: Node2D = $BoxContainer
@onready var ui: CanvasLayer = $UI

@export var rotator_spawn_gap: float = 400
var rotator_current_spawn_y: float


const MAX_ROTATE_SPEED: int = 4
var current_speed: int = 1
var rotators: Array = []
var small_rotators: Array = []
var platforms: Array = []
var boxes_right: Array = []
var boxes_left: Array = []

var player
var score: int = -1
var game_over: bool
var paused: bool = false
var current_level: int


const PLATFORM = preload("res://Scenes/Prefabs/platform.tscn")
const PLAYER = preload("res://Scenes/player.tscn")
const BOX = preload("res://Scenes/Prefabs/box.tscn")
const DEAD_PARTICLES = preload("res://Scenes/Prefabs/dead_particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	rotator_current_spawn_y = rotator_spawn_point_y.global_position.y
	spawn_player()
	ui.set_score_label(score)
	spawn_initial_rotators()



# spawns the initial three rotators.
func spawn_initial_rotators() -> void:
	var is_first: bool = true
	for i in 4:
		is_first = spawn_random_rotator(is_first)
				

func spawn_random_rotator(is_first: bool) -> bool:
	var single = true if randi() % 100 > 20 else false
	var can_start: bool = [false, true, false, false].pick_random()
	if single:
		if is_first:
			spawn_rotator(Manager.rotators.find(Manager.single_big.pick_random()), true)
			is_first = false
		else:
			spawn_rotator(Manager.rotators.find(Manager.single_big.pick_random()))
	else:
		if is_first:
			spawn_double_rotator(true)
			is_first = false
		else:
			spawn_double_rotator(can_start)
	return is_first
	
# spawns a rotator with its idx spawn.
func spawn_rotator(rotator_idx: int, can_start: bool = false) -> void:
	randomize()
	var rotator = load(Manager.rotators[rotator_idx]).instantiate()
	rotator_container.add_child(rotator)
	rotator.can_start = can_start
	rotator.direction = [-1, 1].pick_random()
	rotator.global_position.x = rotator_spawn_point_x.global_position.x
	rotator.global_position.y = rotator_current_spawn_y
	if rotators.size() > 4:
		rotators[0].queue_free()
		rotators.remove_at(0)
	rotators.push_back(rotator)
	
	spawn_boxes(rotator)
	spawn_platform(rotator)
	rotator_current_spawn_y -= rotator_spawn_gap
	if current_level % 3 == 0 && current_speed < MAX_ROTATE_SPEED:
		current_speed += 1
	current_level += 1;
	rotator.speed = clamp(randf_range(1, current_speed), 1, INF)
	

# spawns the central platform.
func spawn_platform(rotator_ref: Node) -> void:	
	var platform = PLATFORM.instantiate()
	platform_container.add_child(platform)
	platform.global_position.x = rotator_spawn_point_x.global_position.x
	platform.global_position.y = rotator_current_spawn_y
	if platforms.size() > 4:
		platforms[0].queue_free()
		platforms.remove_at(0)
	platforms.push_back(platform)
	
# spawns the left and right boxes.
func spawn_boxes(rotator_ref: Node) -> void:
	var box_r = BOX.instantiate()
	var box_l = BOX.instantiate()
	box_container.add_child(box_r)
	box_container.add_child(box_l)
	box_r.global_position.x = box_spawn_right_x.global_position.x
	box_l.global_position.x = box_spawn_left_x.global_position.x
	box_r.global_position.y = rotator_current_spawn_y
	box_l.global_position.y = rotator_current_spawn_y
	
	rotator_ref.box_r = box_r
	rotator_ref.box_l = box_l
	
	if boxes_right.size() > 4:
		boxes_right[0].queue_free()
		boxes_right.remove_at(0)
	boxes_right.push_back(box_r)
	
	if boxes_left.size() > 4:
		boxes_left[0].queue_free()
		boxes_left.remove_at(0)
	boxes_left.push_back(box_l)
	
	
# spawns the player at the spawn point.
func spawn_player() -> void:
	player = PLAYER.instantiate()
	player.global_position = player_spawn.global_position
	add_child(player)
	
	
# will return the nearest rotator from player y-axis only
func get_nearest_rotator() -> Node:
	var nearest: Node
	var min: float = INF
	for i in rotators:
		if abs(i.global_position.y - player.global_position.y) < min:
			min = abs(i.global_position.y - player.global_position.y)
			nearest = i
	return nearest
	
# increments the score by the passed value.
func increase_score(value: int) -> void:
	score += value
	ui.set_score_label(score)


# spawns the double rotator.
func spawn_double_rotator(can_start: bool = false) -> void:
	var rand_big = Manager.doubles_big.pick_random()
	var rotator = load(rand_big).instantiate()
	rotator_container.add_child(rotator)
	rotator.can_start = can_start
	rotator.direction = [-1, 1].pick_random()
	
	
	rotator.global_position.x = rotator_spawn_point_x.global_position.x
	rotator.global_position.y = rotator_current_spawn_y
	if rotators.size() > 4:
		rotators[0].queue_free()
		rotators.remove_at(0)
	rotators.push_back(rotator)
	
	var rand_small = Manager.doubles_small.pick_random()
	var small_rotator = load(rand_small).instantiate()
	rotator_container.add_child(small_rotator)
	small_rotator.can_start = can_start
	small_rotator.is_big = false
	if rotator.direction == 1:
		small_rotator.direction = -1
	else:
		small_rotator.direction = 1
	
	small_rotator.global_position.x = rotator_spawn_point_x.global_position.x
	small_rotator.global_position.y = rotator_current_spawn_y
	
	
	if small_rotators.size() > 4:
		small_rotators[0].queue_free()
		small_rotators.remove_at(0)
	small_rotators.push_back(small_rotator)
	
	spawn_boxes(rotator)
	spawn_platform(rotator)
	rotator_current_spawn_y -= rotator_spawn_gap
	if current_level % 3 == 0 && current_speed < MAX_ROTATE_SPEED:
		current_speed += 1
	current_level += 1;
	var speed = randf_range(1, current_speed)
	rotator.speed = clamp(speed, 1, INF)
	small_rotator.speed = clamp(speed, 1, INF)

# returns the next rotator with respect to the player.
func get_next_rotator() -> Node2D:
	var idx: int = 0
	for i in rotators:
		idx += 1
		if i == player.current_rotator:
			break
	return rotators[idx]
		
	
# sets the game over things.
func set_game_over(pos: Vector2) -> void:
	var p = DEAD_PARTICLES.instantiate()
	add_child(p)
	p.global_position = pos
	p.emitting = true
	p.finished.connect(func():
		p.queue_free()
		)
	game_over = true
	ui.show_game_over_menu()
	if player.time_scale_tween:
		player.time_scale_tween.kill()
		player.time_scale_tween = null
		Engine.time_scale = 1
	#for i in box_container.get_children():
		#i.kill_tween()

# sets the box to pause or resume mode.
func set_box_pause(a: bool) -> void:
	for i in box_container.get_children():
		i.pause_tween(a)
	
func _on_rotator_spawn_timer_timeout() -> void:
	if get_nearest_rotator() == rotators[-2]:
		spawn_random_rotator(false)
