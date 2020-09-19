extends Actor

func _ready():
	pass # Replace with function body.

func _process(delta):
	rotation += 3 * delta
	
func _physics_process(delta: float) -> void:
	move_and_slide(speed)
	if global_position.x > 4200:
		queue_free()
