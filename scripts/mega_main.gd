extends Node2D

@onready var etapaEspacial = load("res://main.tscn")
@onready var etapaRecoleccion = load("res://planetMain.tscn")

var escenaPlaneta = true

func _ready() -> void:
	if escenaPlaneta:
		var planeta = etapaRecoleccion.instantiate()
		add_child.call_deferred(planeta)
	else:
		var espacio = etapaEspacial.instantiate()
		add_child.call(espacio)

func _process(delta):
	pass
	

func cambioEscena():
	!escenaPlaneta
	print("Escena planeta vale: ", escenaPlaneta)
