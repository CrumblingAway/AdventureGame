extends Node

var _was_first_transition_called : bool = false

var _level_stack : LevelStack = LevelStack.new()

func _ready():
	pass

## First transition to level. Must be called before any other transition.
func first_transition_to_level(level: Level) -> void:
	await get_tree().root.ready
	_was_first_transition_called = true
	transition_to_level(level)

## Transition from level to level.
func transition_to_level(level: Level) -> void:
	assert(_was_first_transition_called, "transition_to_level called before first_transition_to_level")
	
	if _level_stack.is_on_main_level():
		var popped_level : Level = _level_stack.pop()
		popped_level.exit()
		get_tree().root.remove_child(popped_level)
	
	_level_stack.push(level)
	get_tree().root.add_child(_level_stack.tail())
	_level_stack.tail().enter()

## Transition from level/sublevel to sublevel.
func drop_to_sublevel(sublevel: Level) -> void:
	_level_stack.tail().visible = false
	_level_stack.tail().exit()
	
	_level_stack.push(sublevel)
	get_tree().root.add_child(_level_stack.tail())
	_level_stack.tail().enter()

## Transition from sublevel to level/sublevel.
func climb_from_sublevel() -> void:
	var popped_sublevel : Level = _level_stack.pop()
	popped_sublevel.visible = false
	get_tree().root.remove_child(popped_sublevel)
	
	_level_stack.tail().visible = true
	_level_stack.tail().enter()

func get_current_level() -> Level:
	return _level_stack.tail()

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
