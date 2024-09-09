class_name GridMovement2D extends Node2D

@export var _mover : Node2D
@export var _grid : Grid

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

########## Public methods. ##########

func move(direction: Vector2i) -> void:
	if _grid.is_cell_available_for(self):
		_mover.global_position += Vector2(direction * _grid.get_floor_tile_size())
