extends StaticBody2D

@export var speed: int = 3
@export var direction: int = 1

var can_start: bool = false

var box_r
var box_l
var player_entered: bool
var main_ref
var is_big: bool = true

func _ready() -> void:
	main_ref = get_tree().get_first_node_in_group("main")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not main_ref.paused:
		if can_start:
			rotation += speed * delta * direction


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and ((box_l and box_r) || not is_big):
		can_start = true
		player_entered = true
		if is_big:
			body.current_rotator = self
			box_r.tween(box_r.global_position - Vector2(230, 0))
			box_l.tween(box_l.global_position + Vector2(230, 0))
		get_tree().get_first_node_in_group("main").increase_score(1)
