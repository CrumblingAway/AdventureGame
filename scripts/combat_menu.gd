class_name CombatMenu extends Node

@onready var _main_menu : VBoxContainer = $MainMenu
@onready var _weapons_menu : VBoxContainer = $WeaponsMenu
@onready var _items_menu : VBoxContainer = $ItemsMenu

var _weapons : Array[Weapon]
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

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

