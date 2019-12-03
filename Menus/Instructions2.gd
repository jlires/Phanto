extends Node2D
onready var _charge_bar = $Player/CanvasLayer/ExperienceBar

func _ready():
	_charge_bar.initialize($Player.light_load, $Player.light_load)
	pass # Replace with function body.