extends Node2D

var selectionStartPoint = Vector2.ZERO
@onready var selector_area: Area2D = $"../SelectorArea"
@onready var collision_shape_2d: CollisionShape2D = $"../SelectorArea/CollisionShape2D"

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if (selectionStartPoint == Vector2.ZERO 
		&& event is InputEventMouseButton
		&& event.button_index == 2 #2 = click derecho del mouse
		&& event.is_pressed()):
			selectionStartPoint = get_global_mouse_position()
	elif (selectionStartPoint != Vector2.ZERO
		&& event is InputEventMouseButton
		&& event.button_index == 2): #2 = click derecho del mouse
			seleccionar_habitantes()
			selectionStartPoint = Vector2.ZERO

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if selectionStartPoint == Vector2.ZERO: return
	
	var mousePosition = get_global_mouse_position()
	var startX  = selectionStartPoint.x
	var startY = selectionStartPoint.y
	var endX = mousePosition.x
	var endY = mousePosition.y
	
	var lineaAncho = 3.0
	var lineaColor = Color.WHITE
	
	draw_line(Vector2(startX, startY), Vector2(endX, startY), lineaColor, lineaAncho)
	draw_line(Vector2(startX, startY), Vector2(startX, endY), lineaColor, lineaAncho)
	draw_line(Vector2(endX, startY), Vector2(endX, endY), lineaColor, lineaAncho)
	draw_line(Vector2(startX, endY), Vector2(endX, endY), lineaColor, lineaAncho)

func seleccionar_habitantes():
	var tamanio = abs(get_global_mouse_position() - selectionStartPoint)
	var areaPosition = puntoInicialRectangulo()
	selector_area.global_position = areaPosition
	collision_shape_2d.global_position = areaPosition + tamanio / 2
	collision_shape_2d.shape.size = tamanio
	
	await get_tree().create_timer(0.04).timeout
	
	var habitantes = get_tree().get_nodes_in_group("habitante")
	print("habitantes: ", habitantes)
	
	for body in selector_area.get_overlapping_bodies():
		print("body: ", selector_area.get_overlapping_bodies())
		if body in get_tree().get_nodes_in_group("habitante"):
			body.selected = true
			habitantes.erase(body)
			print("body")
	
	for body in habitantes:
		body.selected = false

func puntoInicialRectangulo():
	var nuevaPosicion = Vector2.ZERO
	var mousePosition = get_global_mouse_position()
	
	if selectionStartPoint.x < mousePosition.x: nuevaPosicion.x = selectionStartPoint.x
	else: nuevaPosicion.x = mousePosition.x
	
	if selectionStartPoint.y < mousePosition.y: nuevaPosicion.y = selectionStartPoint.y
	else: nuevaPosicion.y = mousePosition.y
	
	return nuevaPosicion
