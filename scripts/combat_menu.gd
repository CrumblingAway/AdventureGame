class_name CombatMenu extends Node

@onready var _main_menu : VBoxContainer = $MainMenu
@onready var _weapons_menu : VBoxContainer = $WeaponsMenu
@onready var _items_menu : VBoxContainer = $ItemsMenu

var _weapons : Array[Weapon]

########## CombatMenu methods. ##########

func cycle_next_menu_item() -> void:
	print("down")

func cycle_prev_menu_item() -> void:
	print("up")

func press_selected_item() -> void:
	print("e")

func display_main_menu_at(position: Vector2) -> void:
	_main_menu.visible = true
	_weapons_menu.visible = false
	_items_menu.visible = false
	
	_main_menu.global_position = position

func display_weapon_menu_at(position: Vector2) -> void:
	_main_menu.visible = false
	_weapons_menu.visible = true
	_items_menu.visible = false

func display_item_menu_at(position: Vector2) -> void:
	_main_menu.visible = false
	_weapons_menu.visible = false
	_items_menu.visible = true

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

