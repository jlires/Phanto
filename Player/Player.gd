extends KinematicBody2D

## Signals ##
signal move
signal light_battery(battery)
signal idle

## Physics statistics ##
const UP = Vector2(0,-1)
const GRAVITY = 10
const ACCELERATION = 10
const MAX_SPEED = 30
const JUMP_HEIGHT = -150

## Initial state ##
var motion = Vector2()
var is_moving = false
var friction = false
var face = "right"
var on_ladder = false
var flashlight = false
var light_load = 200

## Flashlight ##
func light_on():
	#- Lowers flashlight battery while being used -#
	if light_load == 0:
		hide_light()
	else:
		light_load -= 1
	emit_signal("light_battery", light_load)

func charge_light():
	light_load += 0.5
	emit_signal("light_battery", light_load)
	
func hide_light():
	$Flashlight.hide()
	flashlight = false

func show_light():
	$Flashlight.show()
	flashlight = true

func pos():
	return self.position + Vector2(-10, -10)

func flip_face(dir):
	if dir == "right":
		$Sprite.flip_h = false
	elif dir == "left":
		$Sprite.flip_h = true
	return dir
	
func set_on_ladder(state):
	on_ladder = state
	
func is_on_ladder():
	return on_ladder

## Character Physics and Interaction ## 
func _physics_process(delta):
	if is_on_floor() or not is_on_ladder():
		motion.y += GRAVITY
	friction = true
	
	var m = get_global_mouse_position()
	var pos = self.pos()
	var aim_speed = deg2rad(10)
	
	if pos[0] > m[0]:
		if face == "right":
			face = flip_face("left")
	else:
		if face == "left":
			face = flip_face("right")
	
	## Flashlight ##
	
	if $Flashlight.get_angle_to(m) > 0.1:
	    $Flashlight.rotation += aim_speed
	elif $Flashlight.get_angle_to(m) < -0.1:
	    $Flashlight.rotation -= aim_speed
		
	if Input.is_action_just_pressed("ui_flashlight"):
		if !flashlight and light_load > 0:
			show_light()
		else:
			hide_light()
			
	if flashlight:
		light_on()
	
	## Movement Left-Right ##
	
	if Input.is_action_pressed("ui_right"):
		is_moving = true
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.set_offset(Vector2(2, -1))
		$Animation.play("Run")
	elif Input.is_action_pressed("ui_left"):
		is_moving = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.set_offset(Vector2(-30, -1))
		$Animation.play("Run")
	else:
		is_moving = false
		$Animation.play("Idle")
		friction = true

	## Movement Up-Down ##
	
	if is_moving:
		emit_signal("move")
	else:
		emit_signal("idle")
		
	## Jump or Ladder ##
	if Input.is_action_just_pressed("ui_up"):
		if is_on_ladder():
			motion.y = -10
			$Animation.play("Climb")
		elif is_on_floor():
			motion.y = JUMP_HEIGHT
			$Animation.play("Jump")
				
	if Input.is_action_just_pressed("ui_down"):
		if is_on_ladder():
			motion.y = 10
			$Animation.play("Climb")
	
	if is_on_floor() and friction:
			motion.x = lerp(motion.x, 0, 0.1)

	motion = move_and_slide(motion, UP)
	