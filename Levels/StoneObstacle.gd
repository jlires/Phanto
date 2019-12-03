extends Node2D

var MOVEMENT = 30

func move():
	$StoneDoorOpenSound.play()
	var moved = 0
	while moved < MOVEMENT:
		move_local_y(-2)
		yield(get_tree().create_timer(0.2), "timeout")
		moved += 2		
	#self.set_position($StoneObstacle.get_position() + Vector2(0,-30))
	