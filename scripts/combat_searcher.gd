class_name CombatSearcher extends Node2D

signal enter_combat_level(enemies: Array[Enemy], enemies_distances: Array[int])

@export var _level : Level

@export var _cursor : Node2D
var _cursor_mover : GridMovement2D

########## CombatSearcher methods. ##########

func start_at(position: Vector2) -> void:
	_cursor.global_position = position
	set_cursor_visible(true)

func exit() -> void:
	set_cursor_visible(false)

func set_cursor_visible(is_visible: bool) -> void:
	_cursor.visible = is_visible

func move_cursor(direction: Vector2i) -> void:
	_cursor_mover.move(direction)

func start_combat() -> bool:
	for enemy in _level._enemies:
		if enemy.global_position == _cursor.global_position:
			var enemy_arr : Array[Enemy] = [enemy]
			var dist_arr : Array[int] = [4]
			enter_combat_level.emit(enemy_arr, dist_arr)
			return true
	return false

########## Node2D methods. ##########

func _ready() -> void:
	if _cursor:
		_cursor_mover = _cursor.get_node("GridMovement2D")
		_cursor_mover.set_grid(_level._grid)
	
	enter_combat_level.connect(LevelManager.drop_to_combat_level)

func _process(delta: float) -> void:
	pass

