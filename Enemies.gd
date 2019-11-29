extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 10
const MAX_SPEED = 50
const JUMP_HEIGHT = -200

var motion = Vector2()
var is_moving = false
var friction = false
var face = "right"

signal move

onready var player = get_node("res://Player.tscn")

func pos():
	return self.position + Vector2(-10, -10)
	
	
func ia():
	if abs(player.position.x - position.x) < 10:
		if player.position.x > position.x:
			return "right"
		elif player.position.x < position.x:
			return "left"
	return "idle"

	

func flip_face(dir):
	if dir == "right":
		$Sprite.flip_h = false
	elif dir == "left":
		$Sprite.flip_h = true
	return dir

func _physics_process(delta):
	motion.y += GRAVITY
	friction = false
	
	var m = get_global_mouse_position()
	var pos = self.pos()
	var aim_speed = deg2rad(10)
	
	if pos[0] > m[0]:
		if face == "right":
			face = flip_face("left")
	else:
		if face == "left":
			face = flip_face("right")
	
	if ia() == "right":
		is_moving = true
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		##$Sprite.flip_h = false
		$Sprite.set_offset(Vector2(2, -1))
		$Animation.play("Run")
	elif ia() == "left":
		is_moving = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		##$Sprite.flip_h = true
		$Sprite.set_offset(Vector2(-30, -1))
		$Animation.play("Run")
	else:
		is_moving = false
		$Animation.play("Idle")
		friction = true
		
			
	motion = move_and_slide(motion, UP)
	
	
	if is_moving:
		emit_signal("move")
