class_name CombatLevel extends Node2D

########## Fields. ##########

var _player : Player
var _enemies : Array

var _combat_manager : CombatManager

@onready var _tile_map : TileMap = $TileMap

########## Combat level methods. ##########

func enter(
	enemies: Array[Enemy],
	enemy_distances: Array[int]
) -> void:
	# Create board with dimentions num_of_enemies x (max_enemy_distance + 1)
	var board_height : int = enemies.size() + 2
	var board_width  : int = enemy_distances.max() + 1
	for y in range(board_height):
		for x in range(board_width):
			_tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0 if x == 0 else 1, 0))
	
	# TODO: Add terrain effects.
	_combat_manager = CombatManager.new()
	
	# Place player and enemies.
	var player_position : Vector2 = _tile_map.map_to_local(Vector2i(0, board_height / 2))
	_player = Global.get_player()
	if _player.get_parent():
		_player.reparent(self)
	else:
		add_child(_player)
	_player.global_position = player_position
	
	_enemies = enemies
	for enemy_idx in range(_enemies.size()):
		var enemy : Enemy = _enemies[enemy_idx]
		var enemy_position : Vector2 = _tile_map.map_to_local(Vector2i(enemy_distances[enemy_idx], enemy_idx + 1))
		if enemy.get_parent():
			enemy.reparent(self)
		else:
			add_child(enemy)
		enemy.global_position = enemy_position

func exit() -> void:
	pass

########## Node2D methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

