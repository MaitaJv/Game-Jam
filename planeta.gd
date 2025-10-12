extends RigidBody2D
signal desaparecer 

func _on_body_entered() -> void:
	desaparecer.emit()
