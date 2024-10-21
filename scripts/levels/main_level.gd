extends Node2D

var _main_level : Level
var _combat_level : CombatLevel
var _player : Player

func _ready():
#	_main_level = preload("res://levels/test_level.tscn").instantiate()
#	_player = preload("res://objects/Player.tscn").instantiate()
#	add_child(_player)
#
#	Global.set_player(_player)
#	InputManager.set_player(_player)
#
#	var levels : Array[Level] = [_main_level]
#	LevelManager.setup_with_levels(levels)
#	LevelManager.run()
	_combat_level = preload("res://levels/test_combat_level.tscn").instantiate()
	_player = preload("res://objects/Player.tscn").instantiate()
	var enemies : Array[Enemy] = [
		preload("res://objects/Enemy.tscn").instantiate() as Enemy,
		preload("res://objects/Enemy.tscn").instantiate() as Enemy,
		preload("res://objects/Enemy.tscn").instantiate() as Enemy
	]
	var enemy_distances : Array[int] = [5, 2, 7]
	
	add_child(_combat_level)
	_combat_level.setup(_player, enemies, enemy_distances)

func _process(delta: float) -> void:
	pass
