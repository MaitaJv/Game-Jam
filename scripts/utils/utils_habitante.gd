static func desplazar(direccion:float, direccion_planeta:Vector2, velocidad_valor, animacion, velocity):
	if direccion == 1:
		animacion.flip_h = direccion
	if direccion == -1:
		animacion.flip_h = false
	
	animacion.play("caminar")
	velocity = direccion_planeta.orthogonal() * velocidad_valor * direccion

static func caer(direccion_planeta:Vector2, gravedad, animacion, velocity):
	animacion.play("caminar")
	velocity = direccion_planeta * gravedad
