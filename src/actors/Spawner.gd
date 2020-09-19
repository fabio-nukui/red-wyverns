extends Node2D
class_name Spawner

var _state = 0
var _init_count = 2
var _hammer_count = 5
var _rocket_count = 5
var _bomb_count = 5

var hammer = preload("res://src/actors/Hammer.tscn")
var rocket = preload("res://src/actors/Rocket.tscn")
var bomb = preload("res://src/actors/Bomb.tscn")
var player

func _ready():
	player = get_node("../Player")
	$Timer.wait_time = 1.0
	randomize()

func _on_Timer_timeout():
	state_machine()
	if !player:
		return

	if _state == 1:
		var h = hammer.instance()
		add_child(h)
		h.global_position = Vector2(1900, 2375)
		$Timer.wait_time = rand_range(0.5, 2.0)
	if _state == 2:
		var r = rocket.instance()
		add_child(r)
		r.global_position = Vector2(4200, 2100)
		$Timer.wait_time = rand_range(2.0, 4.0)
	if _state == 3:
		var b = bomb.instance()
		add_child(b)
		var x = player.global_position.x
		b.global_position = Vector2(x - 100, 1300)
		$Timer.wait_time = rand_range(4.0, 5.0)

func state_machine():
	if _init_count == 0:
		_state = 1
		_init_count = -1 
	if _hammer_count == 0:
		_state = 2
		_hammer_count = -1
	if _rocket_count == 0:
		_state = 3
		_rocket_count = -1
	if _bomb_count == 0:
		_state = 4
		_bomb_count = -1
	if _state == 0:
		_init_count -= 1
	elif _state == 1:
		_hammer_count -= 1
	elif _state == 2:
		_rocket_count -= 1
	elif _state == 3:
		_bomb_count -= 1
