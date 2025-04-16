extends Control

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer
@onready var bg_texture_rect: TextureRect = $TextureRect
@onready var bg_color_rect: ColorRect = $ColorRect

const CHARACTER_SHOP_ITEM = preload("res://Scenes/Prefabs/character_shop_item.tscn")

@onready var theme_jungle: Dictionary = {
	$BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_normal.svg"
}

@onready var theme_white: Dictionary = {
	$BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_normal.svg"
}

@onready var theme_space: Dictionary = {
	$BackButton: "res://Assets/GUI/SVG/Buttons/cirlce_green_space_normal.svg"
}


func _ready() -> void:
	_set_theme()
	spawn_character_items()




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
		Manager.THEME.WHITE:
			_theme_data = theme_white
		Manager.THEME.SPACE:
			_theme_data = theme_space
	
	for i in _theme_data:
		if i is TextureButton:
			i.texture_normal = load(_theme_data[i])
		elif i is TextureRect:
			i.texture = load(_theme_data[i])
# spawns all the characters in the shop.
func spawn_character_items() -> void:
	for i in Manager.characters:
		var c = load(i).instantiate()
		c.is_in_menu = true
		c.scale = Vector2(3, 3)
		var item = CHARACTER_SHOP_ITEM.instantiate()
		grid_container.add_child(item)
		item.add_character(c)
		if Manager.unlocked_characters[Manager.characters.find(i)]:
			item.locked_layer.visible = false
			item.show_coin_panel(false)
		else:
			item.show_coin_panel(true)
		if Manager.characters.find(i) == Manager.selected_character:
			item.show_tick(true)
		else:
			item.show_tick(false)
		


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/menu.tscn")
