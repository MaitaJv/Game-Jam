extends RigidBody2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile = load("res://projectile.tscn")
@onready var marker = $Marker2D
@onready var piso = main.get_node("floor")

var canShoot = false
var piso_position

func _ready() -> void:
	piso_position = piso.global_position.y 

func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and canShoot:
		#print("shoot")
		shoot()
		canShoot = false
	if Input.is_action_pressed("down"):
		move_down()
	if Input.is_action_pressed("up"):
		move_up()


func move_down():
	print("DOWN")
	if marker.global_position.y < 200:
		marker.global_position.y += 10

func move_up():
	print("UP", marker.global_position.y)
	marker.global_position.y -= 10

func shoot():
	var instance = projectile.instantiate()
	instance.dir = marker.global_rotation_degrees
	instance.spawnPos = marker.global_position
	instance.spawnRot = marker.global_rotation
	main.add_child.call_deferred(instance)
	print(piso_position)


func _on_cooldown_timeout() -> void:
	canShoot = true
