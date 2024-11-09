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
	_setup_player_menu()
	_player_combat_menu.global_position = _player.global_position
	_player_combat_menu.display_main_menu()

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

func _setup_player_weapons_menu(weapons: Node) -> void:
	# Connect buttons to top and bottom neighbors.
	for weapon_idx in range(weapons.get_children().size() - 1, -1, -1):
		var weapon : Weapon = weapons.get_children()[weapon_idx]
		
		var weapon_button_label : String = "%s (%d,%2.1f)" % [weapon._name, weapon._damage, weapon._accuracy]
		var weapon_button : Button = Button.new()
		weapon_button.text = weapon_button_label
		
		_player_combat_menu.get_node("WeaponsMenu").add_child(weapon_button)
		_player_combat_menu.get_node("WeaponsMenu").move_child(weapon_button, 0)
		
		var next_button : Button = _player_combat_menu.get_node("WeaponsMenu").get_child(1)
		next_button.focus_neighbor_top = weapon_button.get_path()
		weapon_button.focus_neighbor_bottom = next_button.get_path()
	
	# Connect top and bottom buttons.
	if _player_combat_menu.get_node("WeaponsMenu").get_child_count() > 1:
		var first_weapon_button : Button = _player_combat_menu.get_node("WeaponsMenu").get_child(0)
		var last_weapon_button : Button = _player_combat_menu.get_node("WeaponsMenu").get_child(_player_combat_menu.get_node("WeaponsMenu").get_child_count() - 1)
		first_weapon_button.focus_neighbor_top = last_weapon_button.get_path()
		last_weapon_button.focus_neighbor_bottom = first_weapon_button.get_path()

func _setup_player_items_menu(items: Node) -> void:
	# Connect buttons to top and bottom neighbors.
	for item_idx in range(items.get_children().size() - 1, -1, -1):
		var item : Weapon = items.get_children()[item_idx]
		
		var item_button_label : String = "%s (%d,%2.1f)" % [item._name, item._damage, item._accuracy]
		var item_button : Button = Button.new()
		item_button.text = item_button_label
		
		_player_combat_menu.get_node("ItemsMenu").add_child(item_button)
		_player_combat_menu.get_node("ItemsMenu").move_child(item_button, 0)
		
		var next_button : Button = _player_combat_menu.get_node("ItemsMenu").get_child(1)
		next_button.focus_neighbor_top = item_button.get_path()
		item_button.focus_neighbor_bottom = next_button.get_path()
	
	# Connect top and bottom buttons.
	if _player_combat_menu.get_node("ItemsMenu").get_child_count() > 1:
		var first_item_button : Button = _player_combat_menu.get_node("ItemsMenu").get_child(0)
		var last_item_button : Button = _player_combat_menu.get_node("ItemsMenu").get_child(_player_combat_menu.get_node("ItemsMenu").get_child_count() - 1)
		first_item_button.focus_neighbor_top = last_item_button.get_path()
		last_item_button.focus_neighbor_bottom = first_item_button.get_path()

########## Node2D methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

