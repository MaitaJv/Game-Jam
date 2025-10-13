extends CharacterBody2D

@onready var animacion = $AnimatedSprite2D
@onready var planeta = $"../Planeta"

const MIRA = preload("uid://dpsg5dlxo7csm")

@export var velocidad_valor = 50
@export var gravedad = 20

var movimientoAutomatico = false
var ruta
var objetivo_principal

var sobre_piso = false

enum cuadrante_obj {PRIMERO, SEGUNDO, TERCERO, CUARTO}

func _ready():
	pass

func _physics_process(delta):
	var direccion_planeta = global_position.direction_to(planeta.global_position)
	
	var direccion = Input.get_axis("Caminar Izquierda", "Caminar Derecha")
	
	rotation = direccion_planeta.angle() - deg_to_rad(90)
	
	if !sobre_piso:
		caer(direccion_planeta)
	
	if direccion:
		desplazar(direccion, direccion_planeta)
	elif movimientoAutomatico == false:
		animacion.play("quieto")
	
	if Input.is_action_just_pressed("click"):
		var click_position = get_global_mouse_position()
		ir_objetivo(click_position)
	
	if movimientoAutomatico and objetivo_principal != null:
		#print("caminando")
		var distancia = objetivo_principal.distance_to(position)
		if distancia > 20:
			desplazar(ruta, direccion_planeta)
		else:
			movimientoAutomatico = false
			print("position.y: ", position.y)

func desplazar(direccion:float, direccion_planeta:Vector2):
	if direccion == -1:
		animacion.flip_h = direccion
	if direccion == 1:
		animacion.flip_h = false
	
	animacion.play("caminar")
	velocity = direccion_planeta.orthogonal() * velocidad_valor * direccion
	move_and_slide()

func caer(direccion_planeta:Vector2):
	animacion.play("caminar")
	velocity = direccion_planeta * gravedad
	move_and_slide()

func ir_objetivo(click_position: Vector2):
	var click_direccion = click_position - planeta.global_position
	var radio = planeta.get_node("CollisionShape2D").shape.radius
	
	var objetivo = planeta.global_position + click_direccion.normalized() * radio
	print(objetivo)
	
	var instancia_punto = MIRA.instantiate()
	instancia_punto.position = objetivo
	
	get_tree().current_scene.add_child(instancia_punto)
	
	caminar_al_objetivo(click_direccion.normalized(), objetivo)
	
	move_and_slide()

func caminar_al_objetivo(objetivo_v: Vector2, objetivo: Vector2):
	var direccion_planeta = global_position.direction_to(planeta.global_position)
	
	var personaje_v = position - planeta.global_position
	var ang = ang_entre_v(objetivo_v, personaje_v.normalized())
	
	if ang < 0:
		ruta = 1
	else:
		ruta = -1
	
	print("angulo: ", ang)
	
	objetivo_principal = objetivo
	movimientoAutomatico = true

func ang_entre_v(objetivo_v: Vector2, personaje_v: Vector2) -> float:
	return objetivo_v.angle_to(personaje_v)
