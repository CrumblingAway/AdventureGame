extends Node2D

var _main_level : Level
var _player : Player

func _ready():
	_main_level = preload("res://levels/test_level.tscn").instantiate()
	_player = preload("res://objects/Player.tscn").instantiate()
	add_child(_player)

	Global.set_player(_player)
	InputManager.set_player(_player)

	var levels : Array[Level] = [_main_level]
	LevelManager.setup_with_levels(levels)
	LevelManager.run()

func _process(delta: float) -> void:
	pass
