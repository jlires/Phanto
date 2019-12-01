extends Area2D

func _ready():
	set_process(true)

#func _on_loading_point_body_entered(body):
#	if body.get_name() == "Player":
#		body.charge_light()
		
func _process(delta):
	var colliding_body = get_overlapping_bodies()
	for body in colliding_body:
		if body.get_name() == "Player":
			body.charge_light()