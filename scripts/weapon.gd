class_name Weapon extends Node

########## Fields. ##########

@export var _name : String

@export var _damage : int
@export var _accuracy: float

@export var _icon : Sprite2D

########## Weapon methods. ##########

func get_action() -> Action:
	return Action.new()

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

