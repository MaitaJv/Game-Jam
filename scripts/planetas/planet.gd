extends RigidBody2D
signal colision_planet(cuerpo)

@export var speed = 100.0
@export var force = 20.0

func _on_colision_area_body_entered(body: Node2D) -> void:
	colision_planet.emit(body)
