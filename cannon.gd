extends RigidBody2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile = load("res://projectile.tscn")
@onready var marker = $Marker2D

var canShoot = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and canShoot:
		#print("shoot")
		shoot()
		canShoot = false


func shoot():
	var instance = projectile.instantiate()
	instance.dir = marker.global_rotation_degrees
	instance.spawnPos = marker.global_position
	instance.spawnRot = marker.global_rotation
	main.add_child.call_deferred(instance)


func _on_cooldown_timeout() -> void:
	canShoot = true
