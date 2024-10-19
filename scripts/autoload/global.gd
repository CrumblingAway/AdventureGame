extends Node

var _player : Player

func _ready():
	pass

func _process(delta):
	pass

func get_player() -> Player:
	return _player

func set_player(player: Player) -> void:
	_player = player
