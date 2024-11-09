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
var _player_action

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
	_setup_player_menu()
	_player_combat_menu.global_position = _player.global_position
	_player_combat_menu.display_main_menu()
	
	_player_combat_menu.do_button_action.connect(_switch_to_target_selection)

func exit() -> void:
	pass

func process_input() -> bool:
	var is_combat_input : bool = true
	
	match _mode:
		Mode.MENU:
			if Input.is_action_just_pressed("move_up"):
				_player_combat_menu.cycle_prev_menu_item()
			elif Input.is_action_just_pressed("move_down"):
				_player_combat_menu.cycle_next_menu_item()
			elif Input.is_action_just_pressed("action"):
				_player_combat_menu.press_selected_item()
			else:
				is_combat_input = false
		Mode.TARGET_SELECT:
			if Input.is_action_just_pressed("cancel"):
				_mode = Mode.MENU
			else:
				is_combat_input = false
		_:
			pass
	return is_combat_input

func _setup_player_menu() -> void:
	var player_inventory : Node = _player.get_node("Inventory")
		
	# Add buttons for weapons.
	_setup_player_weapons_menu(player_inventory.get_node("Weapons"))
	
	# Add buttons for items.
	_setup_player_items_menu(player_inventory.get_node("Items"))

func _setup_player_weapons_menu(weapons_container: Node) -> void:
	var weapons : Array[Weapon]
	for weapon in weapons_container.get_children():
		weapons.push_back(weapon as Weapon)
	_player_combat_menu.add_weapons_buttons(weapons)

func _setup_player_items_menu(items_container: Node) -> void:
	var items : Array
	for item in items_container.get_children():
		items.push_back(item)
	_player_combat_menu.add_items_buttons(items)

func _switch_to_target_selection(action: Action) -> void:
	_mode = Mode.TARGET_SELECT

########## Node2D methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

