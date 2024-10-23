extends Node


enum Mode
{
	MENU,
	COMBAT_SEARCH,
	COMBAT,
	MOVEMENT,
	NUM_OF_MODES
}

var _player : Player

var _mode : Mode = Mode.MOVEMENT

#var _is_game_paused : bool = false
#var _is_combat_search_mode : bool = false

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	match _mode:
		Mode.MOVEMENT:
			if not _player:
				return
			
			var current_level : Level = LevelManager.get_current_level()
			if not current_level:
				return
			
			if Input.is_action_just_pressed("combat_mode"):
				_mode = Mode.COMBAT_SEARCH
				var combat_searcher : CombatSearcher = current_level.get_node("CombatSearcher");
				if combat_searcher:
					combat_searcher.start_at(_player.global_position)
			elif Input.is_action_just_pressed("action"):
				current_level.activate_transition_at(_player.global_position)
			else:
				var direction : Vector2i = Vector2i.ZERO
				if Input.is_action_just_pressed("move_up"):
					direction = Vector2i.UP
				elif Input.is_action_just_pressed("move_down"):
					direction = Vector2i.DOWN
				elif Input.is_action_just_pressed("move_left"):
					direction = Vector2i.LEFT
				elif Input.is_action_just_pressed("move_right"):
					direction = Vector2i.RIGHT
				_player.move(direction)
		Mode.MENU:
			pass
		Mode.COMBAT_SEARCH:
			if Input.is_action_just_pressed("combat_mode"):
				_mode = Mode.MOVEMENT
				LevelManager.get_current_level().get_node("CombatSearcher").exit()
			elif Input.is_action_just_pressed("action"):
				if LevelManager.get_current_level().get_node("CombatSearcher").start_combat():
					_mode = Mode.COMBAT
			else:
				var direction : Vector2i = Vector2i.ZERO
				if Input.is_action_just_pressed("move_up"):
					direction = Vector2i.UP
				elif Input.is_action_just_pressed("move_down"):
					direction = Vector2i.DOWN
				elif Input.is_action_just_pressed("move_left"):
					direction = Vector2i.LEFT
				elif Input.is_action_just_pressed("move_right"):
					direction = Vector2i.RIGHT
				LevelManager.get_current_level().get_node("CombatSearcher").move_cursor(direction)
		Mode.COMBAT:
			if Input.is_action_just_pressed("action"):
				LevelManager.climb_from_combat_level()
				LevelManager.get_current_level().get_node("CombatSearcher").exit()
				_mode = Mode.MOVEMENT
		_:
			print("Invalid input mode.")
	
#	if not _player:
#		return
#
#	if not _is_game_paused:
#		if Input.is_action_just_pressed("combat_mode"):
#			_is_combat_search_mode = not _is_combat_search_mode
#
#		if not _is_combat_search_mode:
#			var current_level : Level = LevelManager.get_current_level()
#			if current_level:
#				var direction : Vector2i = Vector2i.ZERO
#				if Input.is_action_just_pressed("move_up"):
#					direction = Vector2i.UP
#				elif Input.is_action_just_pressed("move_down"):
#					direction = Vector2i.DOWN
#				elif Input.is_action_just_pressed("move_left"):
#					direction = Vector2i.LEFT
#				elif Input.is_action_just_pressed("move_right"):
#					direction = Vector2i.RIGHT
#				_player.move(direction)
#
#				if Input.is_action_just_pressed("action"):
#					current_level.activate_transition_at(_player.global_position)
#			elif LevelManager.get_current_combat_level():
#				pass
#		else:
#			pass

########## InputManager methods. ##########

func set_player(player: Player) -> void:
	_player = player
