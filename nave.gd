class_name nave
extends CharacterBody2D

#@onready var navioEspacial: StaticBody2D = $"../weapon" pingo

var speed = 300
var click_position = Vector2()
var target_position = Vector2()
var combustible = 100

func _ready() -> void:
	click_position = position
	#navioEspacial.colisionNave.connect(choque)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		look_at(click_position)
	
	if position.distance_to(click_position) > 3 and combustible > 0:
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		move_and_slide()
		combustible -= 0.5
		print("Combustible: ", combustible)
		
func choque():
	print("Detectamos dentro de nave")
	combustible += 25
