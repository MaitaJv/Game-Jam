extends Node

@export var arma : PackedScene
#@onready var arma = load("res://weapon.tscn")
@onready var naviacion = $nave

var randomPosX
var randomPosY

func _on_timer_timeout() -> void:
	var mob = arma.instantiate()
	var mob_spawn_location = $spawnCrates/spawnCratesLocation
	mob_spawn_location.progress_ratio = randf()
	mob.global_position = mob_spawn_location.global_position
	add_child(mob)
	print(mob.global_position)
	if mob.has_signal("colisionNave"):
		mob.colisionNave.connect(naviacion.choque)
