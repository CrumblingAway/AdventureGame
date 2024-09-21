extends Node

var _current_level : Level
var _current_sublevel : Level

func _ready():
	pass

func transition_to_level(level: Level) -> void:
	if _current_level:
		_current_level.exit()
	_current_level = level
	_current_level.enter()

func transition_to_sublevel(sublevel: Level) -> void:
	_current_sublevel = sublevel
	get_tree().root.add_child(_current_sublevel)
	_current_sublevel.enter()

func get_current_level() -> Level:
	return _current_level
