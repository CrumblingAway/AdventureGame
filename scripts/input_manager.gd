extends Node

var _player : Player

var _is_game_paused : bool = false

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var current_level : Level = LevelManager.get_current_level()
	
	if current_level and not _is_game_paused:
		if _player:
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
				current_level.activate_sublevel_at(_player.global_position)

########## InputManager methods. ##########

func set_player(player: Player) -> void:
	_player = player
