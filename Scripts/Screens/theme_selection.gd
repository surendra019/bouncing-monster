extends Control

@onready var bg_texture_rect: TextureRect = $TextureRect
@onready var bg_color_rect: ColorRect = $ColorRect
@onready var theme_heading_label: Label = $Label2
@onready var theme_name_label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var theme_jungle_bg: CompressedTexture2D
@export var theme_space_bg: CompressedTexture2D
@export var theme_white_bg: CompressedTexture2D
@export var theme_water_bg: CompressedTexture2D

@onready var select_button_label: Label = $SelectButton/Label

@onready var theme_white: Dictionary = {
	$NextButton: "res://Assets/GUI/SVG/Buttons/cirlce_normal.svg",
	$PreviousButton: "res://Assets/GUI/SVG/Buttons/cirlce_normal.svg",
	$BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_normal.svg",
	$SelectButton: "res://Assets/GUI/SVG/Buttons/button_medium_normal.svg"
}

@onready var theme_jungle: Dictionary = {
	$NextButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$PreviousButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg",
	$SelectButton: "res://Assets/GUI/SVG/Buttons/button_medium_green_normal.svg"
}


@onready var theme_space: Dictionary = {
	$NextButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$PreviousButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg",
	$SelectButton: "res://Assets/GUI/SVG/Buttons/button_medium_space_normal.svg"
	
}

@onready var theme_water: Dictionary = {
	$NextButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$PreviousButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_water_normal.svg",
	$SelectButton: "res://Assets/GUI/SVG/Buttons/button_medium_water_normal.svg"
}
	
var current_theme: Manager.THEME

func _ready() -> void:
	animation_player.play("ui_init")
	current_theme = Manager.current_theme
	_set_theme()



func _set_theme() -> void:
	var _theme_data: Dictionary
	if Manager.current_theme == current_theme:
		select_button_label.text = "Selected"
	else:
		select_button_label.text = "Select"
		
	if current_theme == Manager.THEME.WHITE:
		theme_heading_label.set("theme_override_colors/font_color", Color.BLACK)
	else:
		theme_heading_label.set("theme_override_colors/font_color", Color.WHITE)
	match current_theme:
		Manager.THEME.JUNGLE:
			_theme_data = theme_jungle
			bg_texture_rect.texture = theme_jungle_bg
			theme_name_label.text = "Jungle"
		Manager.THEME.WHITE:
			_theme_data = theme_white
			theme_name_label.text = "White"
			bg_texture_rect.texture = theme_white_bg
		Manager.THEME.SPACE:
			bg_texture_rect.texture = theme_space_bg
			_theme_data = theme_space
			theme_name_label.text = "Space"
			
		Manager.THEME.WATER:
			_theme_data = theme_water
			bg_texture_rect.texture = theme_water_bg
			theme_name_label.text = "Water"
			
			
	
	for i in _theme_data:
		if i is TextureButton:
			i.texture_normal = load(_theme_data[i])
		elif i is TextureRect:
			i.texture = load(_theme_data[i])
			
			
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/menu.tscn")


func _on_next_button_pressed() -> void:
	current_theme += 1
	if current_theme == Manager.THEME.size():
		current_theme =  0
	_set_theme()


func _on_previous_button_pressed() -> void:
	current_theme -= 1
	if current_theme < 0:
		current_theme = Manager.THEME.size() - 1
	_set_theme()


func _on_select_button_pressed() -> void:
	select_button_label.text = "Selected"
	Manager.current_theme = current_theme
	SaveManager._save()
