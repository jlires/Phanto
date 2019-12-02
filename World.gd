extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _charge_bar = $Player/Camera/ExperienceBar
onready var _player = $Player
onready var _flashlight = $Player/Flashlight

# Called when the node enters the scene tree for the first time.
func _ready():
	_charge_bar.initialize(_player.light_load, _player.light_load)
	_flashlight.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
