class_name Grid extends Node2D

########## Signals. ##########

signal drop_to_sublevel(sublevel: Level)
signal exit_from_level

########## Fields. ##########

@onready var _tile_map : TileMap = $TileMap

@export var _packed_scene_mapping : Dictionary
var _level_mapping : Dictionary

@export var _start_tile : Vector2i
@export var _finish_tile : Vector2i

########## Node methods. ##########

func _ready():
	for key in _packed_scene_mapping.keys():
		_level_mapping[key] = _packed_scene_mapping[key].instantiate()

func _process(delta: float):
	pass

########## Public methods. ##########

func is_cell_available_for(mover: GridMovement2D) -> bool:
	return true

func get_floor_tile_size() -> int:
	return _tile_map.tile_set.tile_size.x

func activate_cell(cell_position: Vector2) -> void:
	var tilemap_position : Vector2i = _tile_map.local_to_map(cell_position)
	if _level_mapping.has(tilemap_position):
		drop_to_sublevel.emit(_level_mapping[tilemap_position])
	elif tilemap_position == _finish_tile:
		exit_from_level.emit()

func get_start_tile() -> Vector2i:
	return _start_tile

func get_finish_tile() -> Vector2i:
	return _finish_tile
