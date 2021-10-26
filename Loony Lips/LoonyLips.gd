extends Control

var player_words = []
var prompts = ["a name", "a noun", "adverb", "adjective"]
var story = "Once upon a time someone called %s ate a %s flavored sandwich which made him feel %s inside. It was a %s day."

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	DisplayText.text = "Welcome to Loony Lips! We're going to have a wonderful time. "
	check_player_words_length()
	PlayerText.grab_focus()


func _on_PlayerText_text_entered(new_text):
	add_to_player_words()

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()


func add_to_player_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()
	
	
func is_story_done():
	return player_words.size() == prompts.size()
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
	
func tell_story():
	DisplayText.text = story % player_words

func prompt_player():
	DisplayText.text += "May I have " + prompts[player_words.size()] + " please?"
	
func end_game():
	PlayerText.queue_free()
	tell_story()
	$VBoxContainer/HBoxContainer/Label.text = "Play Again!"
	
	
	
	
	
