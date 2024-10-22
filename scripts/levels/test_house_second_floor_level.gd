extends Level

func _ready():
	super._ready()

func _process(delta: float) -> void:
	if _player:
		_last_player_location = _player.global_position
	for enemy_idx in range(_enemies.size()):
		_last_enemies_locations[enemy_idx] = _enemies[enemy_idx].global_position

func enter() -> void:
	_player = Global.get_player()
	if _player.get_parent():
		_player.reparent(self, false)
	else:
		add_child(_player)
	
	_player.global_position = _last_player_location
	_player.attach_to_grid(_grid)

func exit() -> void:
	_player = null
