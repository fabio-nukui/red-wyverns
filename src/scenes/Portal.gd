tool

extends Area2D

export (String, FILE) var next_scene_path := ""
export var player_spawn_location := Vector2.ZERO
export var is_ready: bool = true


func _get_configuration_warning() -> String:
	if next_scene_path == "":
		return "next_scene_path must be set for Portal to work"
	else:
		return ""


func _on_Portal_body_entered(body: Node) -> void:
	if not is_ready:
		return
	Global.player_initial_map_position = player_spawn_location
	if get_tree().change_scene(next_scene_path) != OK:
		print("Unavailable scene")
