extends RigidBody2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile = load("res://projectile.tscn")
@onready var marker = $Marker2D

func _ready():
	shoot()

#func _physics_process(delta):
	#rotation_degrees += 75 * delta

func shoot():
	print("Shoooooot")
	var instance = projectile.instantiate()
	instance.dir = marker.global_rotation_degrees
	instance.spawnPos = marker.global_position
	instance.spawnRot = marker.global_rotation
	main.add_child.call_deferred(instance)

func _on_cooldown_timeout():
	shoot()
