extends StaticBody2D
signal colisionNave()

var spawnPos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#global_position = spawnPos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	colisionNave.emit()
	queue_free()
