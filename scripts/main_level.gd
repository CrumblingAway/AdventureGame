extends Node2D

var _test_level : Level

func _ready():
	_test_level = preload("res://levels/test_level.tscn").instantiate()
	add_child(_test_level)
	LevelManager.transition_to_level(_test_level)

func _process(delta: float) -> void:
	pass
