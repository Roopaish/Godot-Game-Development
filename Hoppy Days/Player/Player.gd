extends KinematicBody2D

var motion = Vector2() # Defining a 2D vector, to access position of sprite

const SPEED = 1500
const GRAVITY = 150
const UP = Vector2(0, -1) # To determine what is a floor, Vector2(0,0) is default which tells everything is a wall
const JUMP_SPEED = 2500
const WORLD_LIMIT = 4000
const BOOST_MULTIPLIER = 1.5

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP) # Second argument is used to trigger is_on_floor()

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0

# Keep on increasing down position(gravity or down speed), only if the sprite is not on the floor
func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1 # so bunny doesn't hover on the ceiling, bounce of the ceiling if hit
	else:
		motion.y += GRAVITY
		
func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED
		$JumpSFX.play()

# Playing animation based on movement
func animate():
	emit_signal("animate", motion)
	

func hurt():
	# move_and_slide runs at 60fps, so gravity will act on it immediately
	# Bypassing gravity
	position.y -= 1 # move up by 1 px
	yield(get_tree(),"idle_frame") # wait for a frame, then jump (to bypass gravity)
	motion.y = -JUMP_SPEED
	
	$PainSFX.play()

	
func boost():
	position.y -= 1
	yield(get_tree(),"idle_frame")
	motion.y = -JUMP_SPEED * BOOST_MULTIPLIER



	
