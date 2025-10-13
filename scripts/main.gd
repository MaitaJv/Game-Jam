extends Node2D

@onready var planeta = $Planeta
@onready var habitante = $habitante
@onready var camara = $habitante/Camera2D

func _ready():
	camara.make_current()
	
	pass
