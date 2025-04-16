extends Node


enum MODE {EASY, MEDIUM, HARD}
enum THEME {WHITE, JUNGLE, SPACE, WATER}

var current_theme: THEME = THEME.WHITE
var current_mode: MODE
var unlocked_modes = [1,1,1]
var unlocked_characters = [1,0,0,0,0,0,0,0,0,0,0,0,0,0]
var selected_character = 0

var rotators = [
	"res://Scenes/Prefabs/Rotators/rotator_1.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_2.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_3.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_4.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_5.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_6.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_7.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_8.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_9.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_10.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_11.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_12.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_13.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_14.tscn"
]

var single_big = [
	"res://Scenes/Prefabs/Rotators/rotator_1.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_2.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_4.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_5.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_6.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_8.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_9.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_10.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_11.tscn"
]

var doubles_big = [
	"res://Scenes/Prefabs/Rotators/rotator_1.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_8.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_9.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_10.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_11.tscn"

]


var doubles_small = [
	"res://Scenes/Prefabs/Rotators/rotator_13.tscn",
	"res://Scenes/Prefabs/Rotators/rotator_14.tscn"
]



var characters = [
	"res://Scenes/Prefabs/Characters/1.tscn",
	"res://Scenes/Prefabs/Characters/2.tscn",
	"res://Scenes/Prefabs/Characters/3.tscn",
	"res://Scenes/Prefabs/Characters/4.tscn",
	"res://Scenes/Prefabs/Characters/5.tscn",
	"res://Scenes/Prefabs/Characters/6.tscn",
	"res://Scenes/Prefabs/Characters/7.tscn",
	"res://Scenes/Prefabs/Characters/8.tscn",
	"res://Scenes/Prefabs/Characters/9.tscn",
	"res://Scenes/Prefabs/Characters/10.tscn",
	"res://Scenes/Prefabs/Characters/11.tscn",
	"res://Scenes/Prefabs/Characters/12.tscn",
	"res://Scenes/Prefabs/Characters/13.tscn",
	"res://Scenes/Prefabs/Characters/14.tscn"
]
