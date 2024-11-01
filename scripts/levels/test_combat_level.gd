class_name CombatLevel extends Node2D

enum Mode
{
	MENU,
	TARGET_SELECT,
	NUM_OF_STATES,
}

########## Fields. ##########

var _player : Player
var _enemies : Array[Enemy]
var _enemy_distances : Array[int]
var _selected_enemy_index : int
@onready var _player_combat_menu : CombatMenu = $CombatMenu

var _mode : Mode

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
	_enemy_distances = enemy_distances
	for enemy_idx in range(_enemies.size()):
		var enemy : Enemy = _enemies[enemy_idx]
		var enemy_position : Vector2 = _tile_map.map_to_local(Vector2i(enemy_distances[enemy_idx], enemy_idx + 1))
		if enemy.get_parent():
			enemy.reparent(self)
		else:
			add_child(enemy)
		enemy.global_position = enemy_position
	
	_selected_enemy_index = 0
	
	_mode = Mode.MENU
	_player_combat_menu.global_position = _player.global_position
	_player_combat_menu.display_main_menu()

func exit() -> void:
	pass

func process_input() -> bool:
	var is_combat_input : bool = false
	
	match _mode:
		Mode.MENU:
			if Input.is_action_just_pressed("move_up"):
				_player_combat_menu.cycle_prev_menu_item()
				is_combat_input = true
			elif Input.is_action_just_pressed("move_down"):
				_player_combat_menu.cycle_next_menu_item()
				is_combat_input = true
			elif Input.is_action_just_pressed("action"):
				_player_combat_menu.press_selected_item()
		Mode.TARGET_SELECT:
			if Input.is_action_just_pressed("move_down"):
				# Cycle menu option.
				
				# Cycle enemy.
				_enemies[_selected_enemy_index].get_node("Sprite2D").material.set_shader_parameter("enabled", 0.0)
				_selected_enemy_index = (_selected_enemy_index + 1) % _enemies.size()
				is_combat_input = true
			elif Input.is_action_just_pressed("move_up"):
				# Cycle menu option.
				
				# Cycle enemy.
				_enemies[_selected_enemy_index].get_node("Sprite2D").material.set_shader_parameter("enabled", 0.0)
				_selected_enemy_index = (_selected_enemy_index - 1) % _enemies.size()
				is_combat_input = true
			elif Input.is_action_just_pressed("action"):
				# Display menu.
				
				# Execute menu option.
				
				LevelManager.climb_from_combat_level()
				LevelManager.get_current_level().get_node("CombatSearcher").exit()
				
				is_combat_input = true
		_:
			pass
	return is_combat_input

########## Node2D methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_enemies[_selected_enemy_index].get_node("Sprite2D").material.set_shader_parameter("enabled", 1.0)

