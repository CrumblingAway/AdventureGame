class_name CombatMenu extends Node

signal do_button_action(action: Action)

@onready var _main_menu : VBoxContainer = $MainMenu
@onready var _weapons_menu : VBoxContainer = $WeaponsMenu
@onready var _items_menu : VBoxContainer = $ItemsMenu

var _button_to_action : Dictionary
var _focused_button : Button

########## CombatMenu methods. ##########

func cycle_next_menu_item() -> void:
	_focused_button = _focused_button.get_node(_focused_button.focus_neighbor_bottom)

func cycle_prev_menu_item() -> void:
	_focused_button = _focused_button.get_node(_focused_button.focus_neighbor_top)

func press_selected_item() -> void:
	_focused_button.pressed.emit()

func display_main_menu() -> void:
	_main_menu.visible = true
	_weapons_menu.visible = false
	_items_menu.visible = false
	
	var weapons_button : Button = _main_menu.get_node("Weapons")
	weapons_button.grab_focus()
	_focused_button = weapons_button

func display_weapon_menu() -> void:
	_main_menu.visible = false
	_weapons_menu.visible = true
	_items_menu.visible = false
	
	var back_button : Button = _weapons_menu.get_node("Back")
	back_button.grab_focus()
	_focused_button = back_button

func display_item_menu() -> void:
	_main_menu.visible = false
	_weapons_menu.visible = false
	_items_menu.visible = true
	
	var back_button : Button = _items_menu.get_node("Back")
	back_button.grab_focus()
	_focused_button = back_button

func add_weapons_buttons(weapons: Array[Weapon]) -> void:
	# Connect buttons to top and bottom neighbors.
	for weapon_idx in range(weapons.size() - 1, -1, -1):
		var weapon : Weapon = weapons[weapon_idx]
		
		var weapon_button_label : String = "%s (%d,%2.1f)" % [weapon._name, weapon._damage, weapon._accuracy]
		var weapon_button : Button = Button.new()
		weapon_button.text = weapon_button_label
		
		_weapons_menu.add_child(weapon_button)
		_weapons_menu.move_child(weapon_button, 0)
		
		var next_button : Button = _weapons_menu.get_child(1)
		next_button.focus_neighbor_top = weapon_button.get_path()
		weapon_button.focus_neighbor_bottom = next_button.get_path()
		
		_button_to_action[weapon_button] = weapon.get_action()
		weapon_button.pressed.connect(emit_action.bind(weapon.get_action()))
	
	# Connect top and bottom buttons.
	if _weapons_menu.get_child_count() > 1:
		var first_weapon_button : Button = _weapons_menu.get_child(0)
		var last_weapon_button : Button = _weapons_menu.get_child(_weapons_menu.get_child_count() - 1)
		first_weapon_button.focus_neighbor_top = last_weapon_button.get_path()
		last_weapon_button.focus_neighbor_bottom = first_weapon_button.get_path()

func add_items_buttons(items: Array) -> void:
	# Connect buttons to top and bottom neighbors.
	for item_idx in range(items.size() - 1, -1, -1):
		var item = items[item_idx]
		
		var item_button_label : String = "%s (%d,%2.1f)" % [item._name, item._damage, item._accuracy]
		var item_button : Button = Button.new()
		item_button.text = item_button_label
		
		_items_menu.add_child(item_button)
		_items_menu.move_child(item_button, 0)
		
		var next_button : Button = _items_menu.get_child(1)
		next_button.focus_neighbor_top = item_button.get_path()
		item_button.focus_neighbor_bottom = next_button.get_path()
		
		_button_to_action[item_button] = item_button.get_action()
		item_button.pressed.connect(emit_action.bind(item.get_action()))
	
	# Connect top and bottom buttons.
	if _items_menu.get_child_count() > 1:
		var first_item_button : Button = _items_menu.get_child(0)
		var last_item_button : Button = _items_menu.get_child(_items_menu.get_child_count() - 1)
		first_item_button.focus_neighbor_top = last_item_button.get_path()
		last_item_button.focus_neighbor_bottom = first_item_button.get_path()

func emit_action(action: Action) -> void:
	do_button_action.emit(action)

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

