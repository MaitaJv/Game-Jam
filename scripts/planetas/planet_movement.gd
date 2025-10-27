extends Path2D
@export var speed = 100.0

@onready var path_follow_node: PathFollow2D = $planetMovementFollow
@onready var planet_node: Node2D = $planet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow_node.progress += speed * delta
	planet_node.global_position = path_follow_node.global_position
