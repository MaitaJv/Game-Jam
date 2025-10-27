extends Area2D

var activo = false

func _process(_delta):
    if activo:
        if Input.is_action_just_pressed("cambio"):
            get_tree().change_scene_to_file("res://main.tscn")

func _on_body_entered(_body):
    activo = true

func _on_body_exited(_body):
    activo = false
