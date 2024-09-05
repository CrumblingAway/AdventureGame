class_name Player extends Node2D

@onready var _grid_movement_2d : GridMovement2D = $GridMovement2D

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var direction : Vector2i = Vector2i.ZERO
	if Input.is_action_just_pressed("move_up"):
		direction = Vector2i.UP
	elif Input.is_action_just_pressed("move_down"):
		direction = Vector2i.DOWN
	elif Input.is_action_just_pressed("move_left"):
		direction = Vector2i.LEFT
	elif Input.is_action_just_pressed("move_right"):
		direction = Vector2i.RIGHT
	_grid_movement_2d.move(direction)
