extends RigidBody2D
@onready var projectile = load("res://projectile.tscn")
signal colision_planet(cuerpo)



func _on_colision_area_body_entered(body: Node2D) -> void:
	print("Colision")
	#emit_signal("colision_planet")
	colision_planet.emit(body)
