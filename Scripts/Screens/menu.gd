extends Control

@onready var animation_player_main: AnimationPlayer = $Control/AnimationPlayer
@onready var main_ui: Control = $Control
@onready var mode_selection_ui: Control = $ModeSelection
@onready var mode_button_container: VBoxContainer = $ModeSelection/VBoxContainer
@onready var label: Label = $ModeSelection/Label
@onready var label_2: Label = $ModeSelection/Label2
@onready var label_3: Label = $ModeSelection/Label3
@onready var bg_color_rect: ColorRect = $ColorRect
@onready var bg_texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var theme_jungle_bg: CompressedTexture2D
@export var theme_space_bg: CompressedTexture2D
@export var theme_white_bg: Color = Color.WHITE
@export var theme_water_bg: CompressedTexture2D


@onready var theme_jungle: Dictionary = {
	$Control/PlayButton: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg",
	$Control/HBoxContainer/ShopButton: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg",
	$Control/HBoxContainer/ThemeButton: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg",
	$Control/HBoxContainer2/InfoButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$Control/HBoxContainer2/LeaderBoardButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	 $Control/HBoxContainer2/ShareButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$Control/HBoxContainer2/RatingButton:"res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$Control/HBoxContainer2/MusicButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$ModeSelection/VBoxContainer/Easy: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg",
	$ModeSelection/VBoxContainer/Medium: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg",
	$ModeSelection/VBoxContainer/Hard: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg",
	$ModeSelection/BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg"
}

@onready var theme_white: Dictionary = {
	$Control/PlayButton: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg",
	$Control/HBoxContainer/ShopButton: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg",
	$Control/HBoxContainer/ThemeButton: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg",
	$Control/HBoxContainer2/InfoButton: "res://Assets/GUI/SVG/Buttons/circle_normal.png",
	$Control/HBoxContainer2/LeaderBoardButton: "res://Assets/GUI/SVG/Buttons/circle_normal.png",
	$Control/HBoxContainer2/ShareButton: "res://Assets/GUI/SVG/Buttons/circle_normal.png",
	$Control/HBoxContainer2/RatingButton: "res://Assets/GUI/SVG/Buttons/circle_normal.png",
	$Control/HBoxContainer2/MusicButton: "res://Assets/GUI/SVG/Buttons/circle_normal.png",
	$ModeSelection/VBoxContainer/Easy: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg",
	$ModeSelection/VBoxContainer/Medium: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg",
	$ModeSelection/VBoxContainer/Hard: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg",
	$ModeSelection/BackButton: "res://Assets/GUI/SVG/Buttons/circle_normal.png"
}


@onready var theme_space: Dictionary = {
	$Control/PlayButton: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg",
	$Control/HBoxContainer/ShopButton: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg",
	$Control/HBoxContainer/ThemeButton: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg",
	$Control/HBoxContainer2/InfoButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$Control/HBoxContainer2/LeaderBoardButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$Control/HBoxContainer2/ShareButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$Control/HBoxContainer2/RatingButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$Control/HBoxContainer2/MusicButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$ModeSelection/VBoxContainer/Easy: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg",
	$ModeSelection/VBoxContainer/Medium: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg",
	$ModeSelection/VBoxContainer/Hard: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg",
	$ModeSelection/BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg"
}

@onready var theme_water: Dictionary = {
	$Control/PlayButton: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg",
	$Control/HBoxContainer/ShopButton: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg",
	$Control/HBoxContainer/ThemeButton: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg",
	$Control/HBoxContainer2/InfoButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$Control/HBoxContainer2/LeaderBoardButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$Control/HBoxContainer2/ShareButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$Control/HBoxContainer2/RatingButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$Control/HBoxContainer2/MusicButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$ModeSelection/VBoxContainer/Easy: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg",
	$ModeSelection/VBoxContainer/Medium: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg",
	$ModeSelection/VBoxContainer/Hard: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg",
	$ModeSelection/BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("ui_init")
	_set_theme()
	set_unlocked_modes()
	mode_selection_ui.hide()
	main_ui.show()


func _set_theme() -> void:
	var _theme_data: Dictionary
	
	if Manager.current_theme == Manager.THEME.WHITE:
		bg_texture_rect.hide()
		bg_color_rect.show()
	else:
		bg_texture_rect.show()
		bg_color_rect.hide()
	match Manager.current_theme:
		Manager.THEME.JUNGLE:
			_theme_data = theme_jungle
			bg_texture_rect.texture = theme_jungle_bg
		Manager.THEME.WHITE:
			_theme_data = theme_white
		Manager.THEME.SPACE:
			_theme_data = theme_space
			bg_texture_rect.texture = theme_space_bg
		Manager.THEME.WATER:
			_theme_data = theme_water
			bg_texture_rect.texture = theme_water_bg
			
			
	
	for i in _theme_data:
		if i is TextureButton:
			i.texture_normal = load(_theme_data[i])
		elif i is TextureRect:
			i.texture = load(_theme_data[i])
func set_unlocked_modes() -> void:
	for i in 3:
		var c = mode_button_container.get_child(i).get_node("LockedLayer")
		
		if Manager.unlocked_modes[i]:
			c.hide()
		else:
			c.show()
			
		

func _on_play_button_pressed() -> void:
	main_ui.hide()
	mode_selection_ui.show()
	var t = create_tween()
	t.tween_property(label, "global_position:x", 215, .3)
	t.parallel().tween_property(label_2, "global_position:x", 215, .3)
	t.parallel().tween_property(label_3, "global_position:x", 215, .3)
	t.play()


func _on_back_button_pressed() -> void:
	main_ui.show()
	mode_selection_ui.hide()
	label.global_position.x = 700
	label_2.global_position.x = 700
	label_3.global_position.x = 700
	


func _on_easy_pressed() -> void:
	Manager.current_mode = Manager.MODE.EASY
	get_tree().change_scene_to_file("res://Scenes/Screens/main.tscn")
	


func _on_medium_pressed() -> void:
	Manager.current_mode = Manager.MODE.MEDIUM
	get_tree().change_scene_to_file("res://Scenes/Screens/main.tscn")
	
	


func _on_hard_pressed() -> void:
	Manager.current_mode = Manager.MODE.HARD
	get_tree().change_scene_to_file("res://Scenes/Screens/main.tscn")
	


func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/shop_menu.tscn")


func _on_share_button_pressed() -> void:
	if Engine.has_singleton("SendContentPlugin"):
		var s = Engine.get_singleton("SendContentPlugin")
		s.sendAppLink("Download app!")


func _on_rating_button_pressed() -> void:
	pass


func _on_theme_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/theme_selection.tscn")


func _on_leader_board_button_pressed() -> void:
	GooglePlayServices._show_leader_board()
