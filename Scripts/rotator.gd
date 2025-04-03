extends StaticBody2D

@export var speed: int = 3
@export var direction: int = 1
var can_start: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_start:
		rotation += speed * delta * direction
