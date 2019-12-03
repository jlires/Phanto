extends Node2D

func _ready():
	pass # Replace with function body.
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_grab"):
		var bodies = $Lever/Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and not $Lever.moved:
				$Lever.move()
				print("Next Level")
				