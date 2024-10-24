extends Node

var _was_first_transition_called : bool = false

var _level_stack : LevelStack = LevelStack.new()
var _level_reverse_order : LevelStack = LevelStack.new()
var _combat_level : CombatLevel

func _ready():
	pass

## Setup up manager with given levels.
func setup_with_levels(levels: Array[Level]) -> void:
	for i in range(levels.size() - 1, -1, -1):
		_level_reverse_order.push(levels[i])

## Run level manager.
func run() -> void:
	first_transition_to_level(_level_reverse_order.tail())

## First transition to level. Must be called before any other transition.
func first_transition_to_level(level: Level) -> void:
	await get_tree().root.ready
	_was_first_transition_called = true
	transition_to_level(level)

## Transition from level to level.
func transition_to_level(level: Level) -> void:
	assert(
		_was_first_transition_called,
		"transition_to_level called before first_transition_to_level."
	)
	
	if _level_stack.is_on_main_level():
		var popped_level : Level = _level_stack.pop()
		popped_level.exit()
		get_tree().root.remove_child(popped_level)
	
	_level_stack.push(level)
	get_tree().root.add_child(_level_stack.tail())
	_level_stack.tail().enter()

## Transition from level/sublevel to sublevel.
func drop_to_sublevel(sublevel: Level) -> void:
	assert(
		_level_stack.is_on_main_level() or _level_stack.is_on_sublevel(),
		"drop_to_sublevel called without active level/sublevel."
	)
	
	_level_stack.tail().visible = false
	_level_stack.tail().exit()
	
	_level_stack.push(sublevel)
	get_tree().root.add_child(_level_stack.tail())
	_level_stack.tail().set_player_enter_tile(sublevel.get_start_tile())
	_level_stack.tail().visible = true
	_level_stack.tail().enter()

## Exit from level/sublevel.
func exit_from_level() -> void:
	if _level_stack.is_on_sublevel():
		climb_from_sublevel()
	elif _level_stack.is_on_main_level():
		_level_reverse_order.pop()
		var next_level : Level = _level_reverse_order.tail()
		if next_level:
			transition_to_level(next_level)
		else:
			get_tree().quit() # Quit game

## Transition from sublevel to level/sublevel.
func climb_from_sublevel() -> void:
	assert(
		_level_stack.is_on_sublevel(),
		"climb_from_sublevel called without active sublevel."
	)
	
	var popped_sublevel : Level = _level_stack.pop()
	popped_sublevel.visible = false
	get_tree().root.remove_child(popped_sublevel)
	
	_level_stack.tail().visible = true
	_level_stack.tail().enter()

func drop_to_combat_level(enemies: Array[Enemy], enemies_distances: Array[int]) -> void:
	_combat_level = preload("res://levels/test_combat_level.tscn").instantiate()
	get_tree().root.add_child(_combat_level)
	_combat_level.enter(enemies, enemies_distances)
	_combat_level.visible = true
	
	_level_stack.tail().visible = false
	_level_stack.tail().exit()

func climb_from_combat_level() -> void:
	_combat_level.exit()
	get_tree().root.remove_child(_combat_level)
	_combat_level = null
	
	_level_stack.tail().enter()
	_level_stack.tail().visible = true

func get_current_level() -> Level:
	if _combat_level:
		return null
	return _level_stack.tail()

func get_current_combat_level() -> CombatLevel:
	return _combat_level

class LevelStack:
	
	var _stack : Array[Level]
	
	func _init():
		_stack = []
	
	func tail() -> Level:
		if _stack.size() == 0:
			return null
		return _stack[-1]
	
	func push(level: Level) -> void:
		_stack.push_back(level)
	
	func pop() -> Level:
		return _stack.pop_back()
	
	func is_on_main_level() -> bool:
		return _stack.size() == 1
	
	func is_on_sublevel() -> bool:
		return _stack.size() > 1
