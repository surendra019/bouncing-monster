extends StaticBody2D


@onready var panel: ColorRect = $Panel

@export var active_color: Color


enum STATE {DEACTIVE, ACTIVE}
var state: STATE

func set_state(state: STATE) -> void:
	self.state = state
	match self.state:
		STATE.ACTIVE:
			panel.color = active_color
			
