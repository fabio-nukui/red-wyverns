extends Actor

export var stomp_impulse: = 1000.0
export var is_gravity_enabled: = true

var _jumping = false
var _running = 0.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()

	if Input.is_action_just_pressed("flip_gravity"):
		is_gravity_enabled = not is_gravity_enabled
	if is_gravity_enabled:
		_velocity.y += gravity * delta
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
	set_animation()


func get_direction() -> Vector2:
	var left = Input.get_action_strength("move_left")
	var right = Input.get_action_strength("move_right")
	_running = Input.get_action_strength("run") / 2
	var x = (right - left)*(1.0 + _running)
	var y = -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	var direction = Vector2(x, y)
	return direction


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var output: = linear_velocity
	output.x = speed.x * direction.x
	if direction.y == -1.0:
		output.y = speed.y * direction.y
		_jumping = true
	if is_jump_interrupted:
		output.y = 0.0
	return output


func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var output: = linear_velocity
	output.y = -impulse
	return output
	

func set_animation():
	$PlayerAnimation.flip_h = _velocity.x < 0
	if _jumping:
		$PlayerAnimation.play("Jump")
	else:
		if _velocity.x != 0:
			if _running > 0:
				$PlayerAnimation.play("Run")
			else:
				$PlayerAnimation.play("Walk")
		else:
			$PlayerAnimation.play("Idle")

func _on_PlayerAnimation_animation_finished() -> void:
	if $PlayerAnimation.animation == "Jump":
		_jumping = false
