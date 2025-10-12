extends RigidBody2D

@export var SPEED = 250

var dir : float
var spawnPos : Vector2
var spawnRot : float

func _ready():
	global_position = spawnPos
	global_rotation= spawnRot
	linear_velocity = Vector2(SPEED, 0)
	print(linear_velocity.x)

#func _physics_process(delta):
	#pass
	 


func _on_lifespan_timeout() -> void:
	queue_free()
