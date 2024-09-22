class_name Player extends Node2D

@onready var _grid_movement_2d : GridMovement2D = $GridMovement2D

########## Node methods. ##########

func _ready() -> void:
	print("ballsack")

func _process(delta: float) -> void:
	pass

########## Player methods. ##########

func move(direction: Vector2i) -> void:
	_grid_movement_2d.move(direction)

func attach_to_grid(grid: Grid) -> void:
	_grid_movement_2d.set_grid(grid)
