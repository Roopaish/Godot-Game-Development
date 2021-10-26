extends Control

var player_words = []
var template = [
		{
			"prompts": ["a name", "a noun", "adverb", "adjective"],
			"story": "Once upon a time someone called %s ate a %s flavored sandwich which made him feel %s inside. It was a %s day.",
		},
		{
			"prompts": ["a noun", "a name", "adjective", "another name"],
			"story":"There once was a %s called %s who searched far and wide for mythical %s noun of %s"
		},
		{
			"prompts": ["adjective", "adjective", "noun", "adjective", "adjective", "verb", "verb","verb","adjective","verb"],
			"story": "Yesterday, my friend and I went to the park. On our way to the %s park, we saw big %s balloons tied to a %s. Once we got to the %s park, the sky turned %s. It started to %s and %s. My friend and I %s all the way home. Tomorrow we will try to go to the %s park again and hopefully it doesnt %s!"
		}
		]

var current_story

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	set_current_story()
	DisplayText.text = "Welcome to Loony Lips! We're going to have a wonderful time. "
	check_player_words_length()
	PlayerText.grab_focus()

func set_current_story():
	randomize() 
	current_story = template[randi() % template.size()]

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
	return player_words.size() == current_story.prompts.size()
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
	
func tell_story():
	DisplayText.text = current_story.story % player_words

func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"
	
func end_game():
	PlayerText.queue_free()
	tell_story()
	$VBoxContainer/HBoxContainer/Label.text = "Play Again!"
	
	
	
	
	
