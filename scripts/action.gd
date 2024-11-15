class_name Action extends Node

var _damage : int = 0
var _accuracy : float = 1.0
var _speed : int = 5

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

########## Object methods. ##########

func _to_string() -> String:
	return "Action(dmg=%d, acc=%.1f, spd=%d)" % [_damage, _accuracy, _speed]
