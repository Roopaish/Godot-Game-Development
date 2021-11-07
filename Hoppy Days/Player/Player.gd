extends KinematicBody2D

var motion = Vector2() # Defining a 2D vector, to access position of sprite

const SPEED = 1000
const GRAVITY = 300
const UP = Vector2(0, -1) # To determine what is a floor, Vector2(0,0) is default which tells everything is a wall
const JUMP_SPEED = 3000

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
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY	
		
func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED

# Playing animation based on movement
func animate():
	if motion.y < 0:
		$AnimatedSprite.play('jump')
	elif motion.x > 0:
		$AnimatedSprite.play('walk')
		$AnimatedSprite.flip_h = false
	elif motion.x < 0:
		$AnimatedSprite.play('walk')		
		$AnimatedSprite.flip_h = true # flips the sprite horizontally 
	else:
		$AnimatedSprite.play('idle')
		
	
	
	
	
	
	
