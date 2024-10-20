class_name CombatManager extends Node

########## CombatManager methods. ##########

func attack_target(
	target_health: Health,
	attack: Attack
) -> void:
	target_health.subtract_health(attack.damage_points)

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

