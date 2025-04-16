extends Node


var save_path: String = "res://save.tres"
var save: Save = Save.new()

func _ready() -> void:
	if ResourceLoader.exists(save_path):
		save = ResourceLoader.load(save_path)
		Manager.current_theme = save.current_theme
	else:
		_save()
		

func _save() -> void:
	save.current_theme = Manager.current_theme
	ResourceSaver.save(save, save_path)
