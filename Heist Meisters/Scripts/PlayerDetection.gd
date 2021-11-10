extends "res://Scripts/Character.gd"

const FOV_TOLERANCE = 20 # Field of View angle, half-angle
const MAX_DETECTION_RANGE = 320
const RED = Color(1, .25, .25)
const WHITE = Color(1, 1, 1)

onready var Player = get_node("/root/Level1/Player")

func _process(delta):
	if Player_is_in_FOV_TOLERANCE() and Player_is_in_LOS():
		$Torch.color = RED
	else:
		$Torch.color = WHITE

# Detecting Player if in Field of View
func Player_is_in_FOV_TOLERANCE():
	var NPC_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()

	if abs(direction_to_Player.angle_to(NPC_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false

# Detecting Player if in Line of Sight
func Player_is_in_LOS():
	var space = get_world_2d().direct_space_state # get the 2d space
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self]) # cast a ray from NPC/Enemy/SecurityCamera to Player and exclude self
	
	var distance_to_Player = Player.global_position.distance_to(global_position)
	var Player_in_range = distance_to_Player < MAX_DETECTION_RANGE
	
	if LOS_obstacle.collider == Player and Player_in_range:
		return true
	else:
		return false




