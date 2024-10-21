class_name Health extends Node

########## Signals. ##########

signal health_reached_zero
signal health_reached_max

########## Fields. ##########

@export var max_health_points : int
@export var health_points : int:
	get:
		return health_points
	set(value):
		health_points = value
		if health_points == 0:
			health_reached_zero.emit()
		elif health_points == max_health_points:
			health_reached_max.emit()

########## Health methods. ##########

func add_health(amount: int) -> void:
	health_points = min(max_health_points, health_points + amount)

func subtract_health(amount: int) -> void:
	health_points = max(0, health_points - amount)

func increase_max_health(amount: int) -> void:
	max_health_points += amount

func decrease_max_health(amount: int) -> void:
	max_health_points = max(0, max_health_points - amount)
	health_points = min(health_points, max_health_points)

########## Node methods. ##########

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

