extends StaticBody2D

var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func open():
	open = true
	$DoorOpenSound.autoplay = false
	$DoorOpenSound.play()
	