extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_NewGame_pressed():
	Global.goto_scene("res://Levels/Level 1.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Instructions_pressed():
	# TODO: This function doing the same playgame button
	pass # Replace with function body.
	


## Stylistic hover ##

func _on_PlayGame_mouse_entered():
	$VBoxContainer/PlayGame/Line2D.show()

func _on_PlayGame_mouse_exited():
	$VBoxContainer/PlayGame/Line2D.hide()


func _on_Instructions_mouse_entered():
	$VBoxContainer/Instructions/Line2D.show()


func _on_Instructions_mouse_exited():
	$VBoxContainer/Instructions/Line2D.hide()


func _on_NewGame_mouse_entered():
	$VBoxContainer/NewGame/Line2D.show()


func _on_NewGame_mouse_exited():
	$VBoxContainer/NewGame/Line2D.hide()


func _on_Quit_mouse_entered():
	$VBoxContainer/Quit/Line2D.show()


func _on_Quit_mouse_exited():
	$VBoxContainer/Quit/Line2D.hide()
