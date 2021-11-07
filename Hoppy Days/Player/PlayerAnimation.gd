extends AnimatedSprite


func _on_Player_animate(motion):
	if motion.y < 0:
		play('jump')
	elif motion.x > 0:
		play('walk')
		flip_h = false
	elif motion.x < 0:
		play('walk')		
		flip_h = true # flips the sprite horizontally 
	else:
		play('idle')
