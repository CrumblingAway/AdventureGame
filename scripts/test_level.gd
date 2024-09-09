extends Level

@onready var _player : Player = $player
var sublevel = preload("res://levels/test_sublevel_1.tscn").instantiate()

func _ready():
	Global.set_player(_player)
	get_tree().root.add_child.call_deferred(sublevel)
	Global.get_player().reparent(sublevel)
	Global.get_player().position = Vector2(32, 32)

func _process(delta: float) -> void:
	pass
