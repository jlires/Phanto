extends Node2D

func _ready():
	pass # Replace with function body.
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_grab"):
		var bodies = $Map/Lever/Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and not $Map/Lever.moved:
				$Map/Lever.move()
				$Map/StoneObstacle.move()
				print("Next Level")
				
		var bodies2 = $Map/DoorLevel1/Area2D.get_overlapping_bodies()
		for body in bodies2:
			if body.name == "Player" and not $Map/DoorLevel1.open:
				$Map/DoorLevel1.open()
				print("Previous Level")
				yield(get_tree().create_timer(2), "timeout")
				Global.goto_scene("res://Levels/Level 1.tscn")
				
		var bodies3 = $Map/DoorNextLevel/Area2D.get_overlapping_bodies()
		for body in bodies3:
			if body.name == "Player" and not $Map/DoorNextLevel.open:
				$Map/DoorNextLevel.open()
				print("Main Menu")
				yield(get_tree().create_timer(2), "timeout")
				Global.goto_scene("res://Menus/MainMenu.tscn")
				