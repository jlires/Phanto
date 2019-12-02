extends Node2D

func _ready():
	get_node("WalkWood").playing = false

func _on_Player_move():
	if get_node("WalkWood").playing:
		pass
	else:
		get_node("WalkWood").playing = true


func _on_Player_idle():
	if not get_node("WalkWood").playing:
		pass
	else:
		get_node("WalkWood").playing = false
