extends CanvasLayer

@onready var score_label: Label = $Label
@onready var pause_menu: Control = $PauseMenu
@onready var game_over_menu: Control = $GameOverMenu


func _ready() -> void:
	pause_menu.hide()
	game_over_menu.hide()
	
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


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/menu.tscn")
	


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
