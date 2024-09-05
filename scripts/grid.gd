class_name Grid extends Node2D

@onready var _tile_map : TileMap = $TileMap

########## Node methods. ##########

func _ready():
	pass

func _process(delta: float):
	pass

########## Public methods. ##########

func is_cell_available_for(mover: GridMovement2D) -> bool:
	return true

func get_floor_tile_size() -> int:
	return _tile_map.tile_set.tile_size.x
