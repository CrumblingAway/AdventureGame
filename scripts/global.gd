extends Node

var _player : Player
var _scene_manager : LevelManager

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func set_player(player: Player) -> void:
	_player = player

func get_player() -> Player:
	return _player
