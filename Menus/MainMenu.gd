extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PlayGame_pressed():
	Global.goto_scene("res://Levels/Level 1.tscn")
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()


func _on_Instructions_pressed():
	# TODO: This function doing the same playgame button
	pass # Replace with function body.
