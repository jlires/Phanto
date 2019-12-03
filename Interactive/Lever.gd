extends Node2D

var moved = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.set_flip_h(true)

func move():
	if not moved:
		moved = true
		$AnimatedSprite.play("Move")

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.animation = "Finished"
	$AnimatedSprite.stop()
