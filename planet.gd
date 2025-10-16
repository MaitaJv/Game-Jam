extends RigidBody2D
signal colision_planet(cuerpo)



func _on_colision_area_body_entered(body: Node2D) -> void:
	colision_planet.emit(body)
