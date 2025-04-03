extends Node2D

@onready var rotator_spawn_point_x: Marker2D = $RotatorSpawn
@onready var rotator_container: Node2D = $RotatorContainer
@onready var rotator_spawn_point_y: Marker2D = $RotatorStart

@export var rotator_spawn_gap: float = 200
var rotator_current_spawn_y: float

var rotators: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotator_current_spawn_y = rotator_spawn_point_y.global_position.y
	spawn_rotator(0)

# spawns a rotator with its idx spawn.
func spawn_rotator(rotator_idx: int) -> void:
	var rotator = load(Manager.rotators[rotator_idx]).instantiate()
	rotator_container.add_child(rotator)
	rotator.can_start = true
	rotator.global_position.x = rotator_spawn_point_x.global_position.x
	rotator.global_position.y = rotator_current_spawn_y
	rotator_current_spawn_y -= rotator_spawn_gap
	if rotators.size() > 3:
		rotators[0].queue_free()
		rotators.remove_at(0)
	rotators.push_back(rotator)
	
	
