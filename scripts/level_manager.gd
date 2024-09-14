extends Node

var _current_level : Level

func _ready():
	pass

func transition_to_level(level: Level) -> void:
	if _current_level:
		_current_level.exit()
	_current_level = level
	_current_level.enter()

func transition_to_sublevel(sublevel: Level) -> void:
	pass
