class_name Level extends Node

@export var _grid : Grid
@export var _start_tile : Vector2i
@export var _finish_tile : Vector2i

var _player : Player
var _last_player_location : Vector2

########## Node methods. ##########

func _ready() -> void:
	_grid.transition_to.connect(LevelManager.transition_to_sublevel)
	_last_player_location = _grid._tile_map.map_to_local(_start_tile)

func _process(delta: float) -> void:
	pass

########## Level methods. ##########

func enter() -> void:
	pass

func exit() -> void:
	pass

func move_to_background() -> void:
	pass

func get_start_tile() -> Vector2i:
	return _start_tile

func get_finish_tile() -> Vector2i:
	return _finish_tile

func activate_sublevel_at(position: Vector2) -> void:
	_grid.activate_cell(position)
