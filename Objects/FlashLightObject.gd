extends RigidBody2D

var picked = false


func _input(event):
	if Input.is_action_just_pressed("ui_grab"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				body.get_node("Flashlight").show()
				picked = true
				
				self.hide()
