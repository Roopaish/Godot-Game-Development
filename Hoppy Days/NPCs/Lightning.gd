extends Node2D

const SPEED = 200

func _ready():
	set_as_toplevel(true) # won't inherit transform property of parent
	global_position = get_parent().global_position

func _process(delta):
	position.y += SPEED  * delta
	manage_collision()

func manage_collision():
	var collider = $Area2D.get_overlapping_bodies() # get a list of all bodies that are touching Area2D
	for object in collider:
		if object.name == "Player":
			get_tree().call_group("Gamestate", "hurt")
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
