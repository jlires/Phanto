extends Node2D

func _ready():
	$Player/Flashlight.hide()
	pass # Replace with function body.
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_grab"):
		var bodies = $Door/Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and not $Door.open:
				$Door.open()
				print("Next Level")
				yield(get_tree().create_timer(2), "timeout")
				Global.goto_scene("res://Levels/Level 2.tscn")

