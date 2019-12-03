extends Node2D
onready var _charge_bar = $Player/CanvasLayer/ExperienceBar

func _ready():
	_charge_bar.initialize($Player.light_load, $Player.light_load)
	pass # Replace with function body.
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_grab"):				
		var bodies = $Map/Door/Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and not $Map/Door.open:
				$Map/Door.open()
				print("Main Menu")
				yield(get_tree().create_timer(2), "timeout")
				Global.goto_scene("res://Menus/MainMenu.tscn")