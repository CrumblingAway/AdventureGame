class_name LevelManager extends Node

var _current_level : Level

func _ready():
	pass

func transition_to_level(level: Level) -> void:
	get_tree().root.add_child(level)
