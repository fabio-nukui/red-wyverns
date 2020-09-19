extends Node2D

func _ready() -> void:
	Global.player = get_node("./Player")


func _on_fireStageEnd_body_entered(body: Node) -> void:
	Global.startStageDodge = true
