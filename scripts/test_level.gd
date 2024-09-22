extends Level

func _ready():
	super._ready()

func _process(delta: float) -> void:
	if $player:
		_last_player_location = _player.global_position

func enter() -> void:
	_player = Global.get_player()
	if _player.get_parent():
		_player.reparent(self, false)
	else:
		add_child(_player)
	
	_player.global_position = _last_player_location
	_player.attach_to_grid(_grid)
