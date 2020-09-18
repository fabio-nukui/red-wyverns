extends KinematicBody2D

export var cycle_speed: = 5.0
export var displacement: = 100.0
var _height: = 0.0
var _angle: = 0.0


func _ready():
	set_process(true)
	_height = position.y


func _physics_process(delta: float) -> void:
	   _angle += cycleSpeed * delta

#		var offset = sin(_angle) * displacement
		var pos = _centre + offset
		move(pos) 
		_velocity = move_and_slide(_velocity)


func _ready() -> void:
	set_physics_process(false)


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()


func _physics_process(delta: float) -> void:
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, Vector2.UP).y
