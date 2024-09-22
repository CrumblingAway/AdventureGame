extends Node2D

var _main_level : Level
var _player : Player

func _ready():
	_main_level = preload("res://levels/test_level.tscn").instantiate()
	_player = preload("res://objects/Player.tscn").instantiate()
	_player._ready()
	Global.set_player(_player)
	InputManager.set_player(_player)
	LevelManager.first_transition_to_level(_main_level)

func _process(delta: float) -> void:
	pass
