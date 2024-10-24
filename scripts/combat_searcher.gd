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
	var enemy_group : int = -1
	for enemy in _level._enemies:
		if enemy.global_position == _cursor.global_position:
			enemy_group = enemy._group
	
	var enemies : Array[Enemy]
	var distances : Array[int]
	for enemy in _level._enemies:
		if enemy._group == enemy_group:
			enemies.push_back(enemy)
			distances.push_back(int((_level._player.global_position - enemy.global_position).abs().dot(Vector2.ONE) / _level._grid._tile_map.tile_set.tile_size.x))
	
	if enemies:
		enter_combat_level.emit(enemies, distances)
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

