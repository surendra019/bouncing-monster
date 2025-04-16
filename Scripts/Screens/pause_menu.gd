extends Control


@onready var theme_jungle: Dictionary = {
	$HBoxContainer/ShareButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$HBoxContainer/RestartButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$ResumeButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$VBoxContainer/WatchVideoButton: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg",
	$VBoxContainer/MainMenuButton: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg"
}


@onready var theme_white: Dictionary = {
	$HBoxContainer/ShareButton: "res://Assets/GUI/SVG/Buttons/cirlce_normal.svg",
	$HBoxContainer/RestartButton: "res://Assets/GUI/SVG/Buttons/cirlce_normal.svg",
	$ResumeButton: "res://Assets/GUI/SVG/Buttons/cirlce_normal.svg",
	$VBoxContainer/WatchVideoButton: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg",
	$VBoxContainer/MainMenuButton: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg"
}
@onready var theme_space: Dictionary = {
	$HBoxContainer/ShareButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$HBoxContainer/RestartButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$ResumeButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$VBoxContainer/WatchVideoButton: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg",
	$VBoxContainer/MainMenuButton: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg"
}
@onready var theme_water: Dictionary = {
	$HBoxContainer/ShareButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$HBoxContainer/RestartButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$ResumeButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$VBoxContainer/WatchVideoButton: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg",
	$VBoxContainer/MainMenuButton: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_theme()

func _set_theme() -> void:
	var _theme_data: Dictionary
	match Manager.current_theme:
		Manager.THEME.JUNGLE:
			_theme_data = theme_jungle
		Manager.THEME.WHITE:
			_theme_data = theme_white
		Manager.THEME.SPACE:
			_theme_data = theme_space
		Manager.THEME.WATER:
			_theme_data = theme_water
	
	for i in _theme_data:
		if i is TextureButton:
			i.texture_normal = load(_theme_data[i])
		elif i is TextureRect:
			i.texture = load(_theme_data[i])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_share_button_pressed() -> void:
	if Engine.has_singleton("SendContentPlugin"):
		var s = Engine.get_singleton("SendContentPlugin")
		s.sendAppLink("Download app!")
