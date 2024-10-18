class_name Level extends Node

@export var _grid : Grid

var _player : Player
var _last_player_location : Vector2

########## Node methods. ##########

func _ready() -> void:
	_grid.drop_to_sublevel.connect(LevelManager.drop_to_sublevel)
	_grid.exit_from_level.connect(LevelManager.exit_from_level)
	_last_player_location = _grid._tile_map.map_to_local(_grid.get_start_tile())

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
	return _grid.get_start_tile()

func get_finish_tile() -> Vector2i:
	return _grid.get_finish_tile()

func activate_transition_at(position: Vector2) -> void:
	_grid.activate_cell(position)

func set_player_enter_tile(tile: Vector2) -> void:
	_last_player_location = _grid._tile_map.map_to_local(tile)
