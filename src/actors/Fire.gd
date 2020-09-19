extends KinematicBody2D

export var rotation_speed := 4.0
export var radius := 100.0
export var y_excentricity = 3
var _centre
var _angle := 0.0


func _ready():
	set_process(true)
	_centre = position


func _process(delta):
	_angle += rotation_speed * delta
	var offset = Vector2(sin(_angle), cos(_angle) * y_excentricity) * radius
	position = _centre + offset
