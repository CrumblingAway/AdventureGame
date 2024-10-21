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
		Mode.MENU:
			pass
		Mode.COMBAT_SEARCH:
			pass
		Mode.COMBAT:
			pass
		Mode.MOVEMENT:
			if not _player:
				return
				
			var current_level : Level = LevelManager.get_current_level()
			if current_level:
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

				if Input.is_action_just_pressed("action"):
					current_level.activate_transition_at(_player.global_position)
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
