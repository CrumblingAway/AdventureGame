extends Node


enum Mode
{
	PAUSE,
	COMBAT_SEARCH,
	COMBAT,
	MOVEMENT,
	NUM_OF_MODES
}

var _player : Player

var _mode : Mode = Mode.MOVEMENT
var _prev_mode : Mode = Mode.NUM_OF_MODES

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
			elif Input.is_action_just_pressed("pause"):
				_prev_mode = _mode
				_mode = Mode.PAUSE
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
		Mode.PAUSE:
			if Input.is_action_just_pressed("pause"):
				_mode = _prev_mode
		Mode.COMBAT_SEARCH:
			if Input.is_action_just_pressed("combat_mode"):
				_mode = Mode.MOVEMENT
				LevelManager.get_current_level().get_node("CombatSearcher").exit()
			elif Input.is_action_just_pressed("action"):
				if LevelManager.get_current_level().get_node("CombatSearcher").start_combat():
					_mode = Mode.COMBAT
			elif Input.is_action_just_pressed("pause"):
				_prev_mode = _mode
				_mode = Mode.PAUSE
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
			if not LevelManager.get_current_combat_level():
				_mode = Mode.MOVEMENT
			elif LevelManager.get_current_combat_level().process_input():
				return
			elif Input.is_action_just_pressed("pause"):
				_prev_mode = _mode
				_mode = Mode.PAUSE
		_:
			print("Invalid input mode.")

########## InputManager methods. ##########

func set_player(player: Player) -> void:
	_player = player
