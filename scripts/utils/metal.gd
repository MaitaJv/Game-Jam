class_name metal
extends StaticBody2D

@export var nombre = "metal"
@export var vida = 100
@export var cantidad = 25

func _ready() -> void:
	add_to_group("recursos")
