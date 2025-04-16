extends Control


@onready var coin_panel: Panel = $CharacterShopItem/CoinPanel
@onready var tick: TextureRect = $CharacterShopItem/Tick
@onready var character_container: Marker2D = $CharacterShopItem/Marker2D
@onready var locked_layer: Panel = $CharacterShopItem/LockedLayer

var character_idx: int



func show_tick(a: bool) -> void:
	tick.visible = a
	
func add_character(c: Node2D) -> void:
	character_container.add_child(c)


func show_coin_panel(a: bool) -> void:
	coin_panel.visible = a
