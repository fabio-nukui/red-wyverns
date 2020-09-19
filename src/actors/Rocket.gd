extends Actor

var amplitude = 20000.0
var freq = 5.0
var time = 0.0

func _ready():
	freq = rand_range(1.0, 10.0)
	amplitude *= freq
	_velocity.x = -speed.x
	
func _physics_process(delta: float) -> void:
	time += delta
	_velocity.y = delta * cos(time * freq) * amplitude
	_velocity = move_and_slide(_velocity)
	if global_position.x < 1900:
		queue_free()
