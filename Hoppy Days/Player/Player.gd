extends KinematicBody2D

var motion = Vector2()

const SPEED = 500

func _physics_process(delta):
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0
	move_and_slide(motion)
