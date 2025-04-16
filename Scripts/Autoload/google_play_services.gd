extends Node

var _play_service = null
var leaderboard_id: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _start_services() -> void:
	if Engine.has_singleton("GooglePlayGamesServices"):
		_play_service = Engine.get_singleton("GooglePlayGamesServices")
		_play_service.init(true, false, false, "")

func _sign_in() -> void:
	if _play_service:
		_play_service.signIn()

func _connect_signals() -> void:
	if _play_service:
		_play_service.connect("_on_sign_in_success", _on_sign_in_success)
		_play_service.connect("_on_sign_in_failed", _on_sign_in_failed)
		
func _submit_score(score: int) -> void:
	if _play_service:
		_play_service.submitLeaderBoardScore(leaderboard_id, "")
	
func _show_leader_board() -> void:
	if _play_service:
		_play_service.showLeaderBoard()

func _on_sign_in_success(account_id) -> void:
	pass


func _on_sign_in_failed(account_id) -> void:
	pass
