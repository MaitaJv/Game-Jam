class_name Projectile
extends RigidBody2D

@onready var planet: RigidBody2D = $"../planetMovement/planet"

@export var speed = 600

var dir : float
var spawnPos : Vector2
var spawnRot : float

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	linear_velocity = Vector2(speed, 250)
	planet.colision_planet.connect(choque)

func choque(objeto):
	if objeto == self:
		queue_free()
		print("body:", objeto)

func _on_timer_timeout() -> void:
	pass
