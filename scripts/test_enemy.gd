class_name Enemy extends Node2D

@export var _group : int = 0

@export var _attack_speed : int

########## Enemy methods. ##########

func get_action_and_target() -> Array:
	return [Action.new(), self]

########## Node2D methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

