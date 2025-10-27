extends CharacterBody2D

@onready var animacion = $AnimatedSprite2D
@onready var planeta = $"../Planeta"
@onready var label: Label = $Label

const MIRA = preload("uid://dpsg5dlxo7csm")

@export var velocidad_valor = 50
@export var gravedad = 20

var movimientoAutomatico = false
var ruta
var objetivo_principal

var sobre_piso = false
var selected = false
var bloqueado = false

var inventario = []

func _ready():
	add_to_group("habitante")

func _process(delta: float) -> void:
	label.visible = selected

func _physics_process(delta):
	var direccion_planeta = global_position.direction_to(planeta.global_position)
	
	up_direction = -direccion_planeta
	
	var direccion = Input.get_axis("Caminar Izquierda", "Caminar Derecha")
	
	rotation = direccion_planeta.angle() - deg_to_rad(90)
	
	if not is_on_floor():
		caer(direccion_planeta)
	
	if direccion and !bloqueado:
		desplazar(direccion, direccion_planeta)
	elif movimientoAutomatico == false:
		animacion.play("quieto")
	
	if Input.is_action_just_pressed("click") and selected and !bloqueado:
		var click_position = get_global_mouse_position()
		ir_objetivo(click_position)
	
	if movimientoAutomatico and objetivo_principal != null and !bloqueado:
		var distancia = objetivo_principal.distance_to(position)
		if distancia > 20:
			desplazar(ruta, direccion_planeta)
		else:
			movimientoAutomatico = false
			print("position.y: ", position.y)
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var colision = get_slide_collision(i)
		var cuerpo_colision = colision.get_collider()
		
		if cuerpo_colision in get_tree().get_nodes_in_group("recursos"):
			bloqueado = true
			cuerpo_colision.get_node("CollisionShape2D").disabled = true
			
			await recolectar()
			
			inventario.push_front({"recurso": cuerpo_colision.nombre,"cantidad": cuerpo_colision.cantidad})
			print("inventario: ", inventario)
			cuerpo_colision.queue_free()

func desplazar(direccion:float, direccion_planeta:Vector2):
	if direccion == 1:
		animacion.flip_h = direccion
	if direccion == -1:
		animacion.flip_h = false
	
	animacion.play("caminar")
	velocity = direccion_planeta.orthogonal() * velocidad_valor * direccion

func caer(direccion_planeta:Vector2):
	animacion.play("caminar")
	velocity = direccion_planeta * gravedad

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

func recolectar():
	await get_tree().create_timer(10).timeout
	bloqueado = false
