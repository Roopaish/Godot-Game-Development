extends Node2D

var lives = 3
var coins = 0
var target_number_of_coins = 10

func _ready():
	add_to_group("Gamestate")
	update_GUI() # just to show correct number at start when changing lives value

func hurt():
	lives -= 1
	$Player.hurt()
	update_GUI()
	if lives < 0:
		end_game()

func update_GUI():
	get_tree().call_group("GUI", "update_GUI", lives, coins)
	
func coin_up():
	coins += 1
	update_GUI()
	
	var multiple_of_coins = (coins % target_number_of_coins) == 0
	if multiple_of_coins:
		life_up()

func life_up():
	lives += 1
	update_GUI()

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")
