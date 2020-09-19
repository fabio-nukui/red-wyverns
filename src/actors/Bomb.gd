extends Actor

var explosion = preload("res://assets/levels-09.png")

func _ready():
	$Circle.shape.radius = 0	
	$Timer.set_paused(true)
	$Timer2.set_paused(true)
	$Timer3.set_paused(true)

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity = move_and_slide(_velocity, Vector2.UP)
	if is_on_floor() and $Timer.is_paused():
		$Timer.set_paused(false)
		$Timer2.set_paused(false)
		$Timer3.set_paused(false)
		$Image.rotation_degrees = -5


func _on_Timer_timeout():
	$Image.rotation_degrees *= -1
	$Timer.wait_time /= 2
	
func _on_Timer2_timeout():
	$Timer.stop()
	$Timer2.stop()
	$Image.rotation_degrees = 0	
	$Image/Sprite.rotation_degrees = 0
	$Image/Sprite.set_texture(explosion)
	$Circle.shape.radius = 900

func _on_Timer3_timeout():
	queue_free()
