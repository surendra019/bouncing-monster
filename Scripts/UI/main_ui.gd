extends CanvasLayer

@onready var pause_menu: Control = $PauseMenu
@onready var score_label: Label = $Label/Label
@onready var game_over_menu: Control = $GameoverMenu
@onready var fade_effect_rect: ColorRect = $FadeEffectRect

@onready var theme_jungle: Dictionary = {
	$Label: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg",
	$PauseButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
}

@onready var theme_white: Dictionary = {
	$Label: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg",
	$PauseButton: "res://Assets/GUI/SVG/Buttons/circle_normal.png"
}

@onready var theme_space: Dictionary = {
	$PauseButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$Label: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg"
}

@onready var theme_water: Dictionary = {
	$Label: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg",
	$PauseButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg"
}
func _ready() -> void:
	_set_theme()
	pause_menu.hide()
	game_over_menu.hide()
	play_fade_out()

# plays the fade out effect in the starting of the game
func play_fade_out() -> void:
	fade_effect_rect.show()
	var t = create_tween()
	t.tween_property(fade_effect_rect, "modulate:a", 0.0, 1)
	t.play()
	t.tween_callback(func():
		fade_effect_rect.hide()
		)


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
			
			
# toggles the visibilty of the pause menu.
func show_pause_menu() -> void:
	pause_menu.show()

func show_game_over_menu() -> void:
	game_over_menu.show()
	
# sets the text.
func set_score_label(score: int) -> void:
	score_label.text = str(score)


func _on_pause_button_pressed() -> void:
	show_pause_menu()
	get_parent().paused = true
	get_parent().set_box_pause(true)


func _on_resume_button_pressed() -> void:
	pause_menu.hide()
	get_parent().paused = false
	get_parent().set_box_pause(false)
	


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()



func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/menu.tscn")
	
