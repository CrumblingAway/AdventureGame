class_name CombatSearcher extends Node2D

@export var _grid : Grid

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

########## Node2D methods. ##########

func _ready() -> void:
	if _cursor:
		_cursor_mover = _cursor.get_node("GridMovement2D")
		_cursor_mover.set_grid(_grid)

func _process(delta: float) -> void:
	pass

