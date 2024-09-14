class_name Grid extends Node2D

########## Signals. ##########

signal transition_to(level: Level)

########## Fields. ##########

@onready var _tile_map : TileMap = $TileMap

@export var _level_mapping : Dictionary

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

func activate_cell(cell_position: Vector2i) -> void:
	if _level_mapping.has(cell_position):
		transition_to.emit(_level_mapping[cell_position])
