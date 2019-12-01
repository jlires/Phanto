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
var flashlight = false
# Variable con estado inicial de la linterna
var light_load = 200

signal move
signal light_battery(battery)

# Funcion que disminuye la carga de linterna cuando se prende
func light_on():
	if light_load == 0:
		hide_light()
	else: 
		light_load -= 1
	emit_signal("light_battery", light_load)


func charge_light():
	light_load += 0.5
	emit_signal("light_battery", light_load)


func pos():
	return self.position + Vector2(-10, -10)


func flip_face(dir):
	if dir == "right":
		$Sprite.flip_h = false
	elif dir == "left":
		$Sprite.flip_h = true
	return dir


func hide_light():
	$Flashlight.hide()
	flashlight = false


func show_light():
	$Flashlight.show()
	flashlight = true


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
	
	if $Flashlight.get_angle_to(m) > 0.1:
	    $Flashlight.rotation += aim_speed
	elif $Flashlight.get_angle_to(m) < -0.1:
	    $Flashlight.rotation -= aim_speed
	
	if Input.is_action_pressed("ui_right"):
		is_moving = true
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		##$Sprite.flip_h = false
		$Sprite.set_offset(Vector2(2, -1))
		$Animation.play("Run")
	elif Input.is_action_pressed("ui_left"):
		is_moving = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		##$Sprite.flip_h = true
		$Sprite.set_offset(Vector2(-30, -1))
		$Animation.play("Run")
	else:
		is_moving = false
		$Animation.play("Idle")
		friction = true
		
	if Input.is_action_just_pressed("ui_flashlight"):
		if !flashlight and light_load > 0:
			show_light()
		else:
			hide_light()
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			$Animation.play("Jump")
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		is_moving = true
		if friction:
			motion.x = lerp(motion.x, 0, 0.05)
			
	motion = move_and_slide(motion, UP)
	
	
	if is_moving:
		emit_signal("move")
	if flashlight:
		light_on()
		