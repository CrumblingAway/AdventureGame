extends Node

var _player : Player

func _ready():
	_player = preload("res://objects/Player.tscn").instantiate()
	InputManager.set_player(_player)

func _process(delta):
	pass

func get_player() -> Player:
	return _player
