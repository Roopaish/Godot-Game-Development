# Godot Game Development

Games made with [Godot Engine](https://godotengine.org/), free and open-source game engine.

- [Loony Lips - Discovering GDScript](#loony-lips---discovering-gdscript)
- Hoopy Days - Discovering the Engine
- Heist Meisters - Top-Down-Stealth
- CubeDude Kickabout - 3D Local Multiplayer
- Food Fight - Advanced 3D

## Loony Lips - Discovering GDScript

- Theme

A Word game,  
Ask for a word based on type(nouns, verb, etc)  
Then plug the words into expnadable template for stories

- Basics and Arrays

Godot is comprised of nodes. Nodes can have childrens. It's just like Widgets of Flutter.
NodeName are named like this: LoonyLips;  

```gdscript
# inherits properties of Control node (class), it get automatically added when attaching script to a node (Control in this case)
extends Control

// _ready() fucntion run at start like a main() fxn in C++

func _ready():
	var person = "Yann"
	print("Hello " + person)
	
	person = "Someone else"
	print("Hello World!" + person)

	var prompts = ["Yann", "Minions", "Greatest"]
	var story = "Once upon a time %s watched %s and thought is was the %s movie of the past two decades"
	print(story % prompts)

	prompts = ["Izabella", "Dune", "Biggest"]
	print(story % prompts)

	# Here in story %s will be replaced by each element of prompts one by one
	# %s should occur exactly 3times as prompts have 3 element or error will be thrown
```

```
// Output
 
Hello Yann
Hello Someone else
Once upon a time Yann watched Minions and thought is was the Greatest movie of the past two decades
Once upon a time Izabella watched Dune and thought is was the Biggest movie of the past two
```

- TextureRect, Label  

`TextureRect node for background`  
Drag background to Texture in Inspector. Press play, when resizing the window, it looks like the background is cutting but not expanding.  
So go back and click on expand. Changes won't be reflected on the editor, so add a new scene and come back to the previuos scene, changes will be refelected and the background will look small. 
  
Click on the node -> Layout -> Anchors only -> Full rect to measure the bounding rectangle(screen) so it knows where to expand.  
Now click node -> Layout -> Full Rect. Now the texture will cover the full rectangle and will shrink and expand on changing screen sizes.

Change default size of the window, Project -> Project Setting -> General -> Window -> Under Size

`label node is used display something on the screen`  
Custom fonts can be added by creating new dynamic font from inpector, margin, auto-wrap etc can be done.

```gdscript
// Access the child node
// Hover over the Properties of Node in Inspector to know the property name of it, so we can access them using . operator
// We can also drag Node to script to access the path along its name (Label in this case)
get_node("Label").text = "Changed Text"
$Label.text = "Another Changed Text"

// Use "" to access node with space in its name
// However its not a convenion to do so
$"Label Name".text = "Text for label name"

// Showing Story to screen
var prompts = ["Yann", "Minions", "Greatest"]
var story = "Once upon a time %s watched %s and thought is was the %s movie of the past two decades"
	
$DisplayText.text = story % prompts
```

There's RichLabelText which is like Label but we can make certain part of text underlined, bold etc.(Bb code)

- LineEdit, VBoxContainer, HBoxContainer, Button

Getting text from Player  
`LineEdit is for single line input` and `TextEdit for multi line input`  
```gdscript
# shift focus to the LineEdit, so that we can start typing immediately
func _ready():
	LineEdit.grab_focus()
```

`VBoxContainer to align nodes in row` and `HBoxContainer to align nodes in column`  
We can change alignment, margins etc

Select LineEdit, In node tab, click text_entered and connect to first node where script is attached

```gdscript
// This fxn will get automatically added
func _on_PlayerText_text_entered(new_text):
	pass # Replace with function body.
	$Label.text = new_text
	# entered text will be shown in the screen
	LineEdit.clear() # to clear the entered text from LineEdit
```

`TextureButton to make a button with textures`  
Here TextureButton and LineEdit are placed in HBoxContainer. LineEdit  -> Size Flags -> Expand (so it will expand to available space).   
  
TextureButton -> Rect -> Set the proper size to match the look of LineEdit. This will set the size of Node not the texture. TextureButton -> Turn expand on (it will vanis) , now go to Rect and give the node a minimum size. Everything will work now.  
  
HBoxContainer and VBoxConatainer has Custom Constants -> Separation property to set the spacing between child nodes.
  
```gdscript
// Changing screen's text when button is pressed
func _on_TextureButton_pressed():
	var new_text = $VBoxContainer/HBoxContainer/LineEdit.text
	update_Label(new_text)

```

- array methods and if-else

```gdscript
func add_to_player_words():
	player_words.append(PlayerText.text)
	# Add new elements in the array
	
func is_story_done():
	return player_words.size() == prompts.size()
	# .size() returns length of array
	
func check_player_words_length():
	if is_story_done():
		pass
	elif not is_story_done():
		pass
	else:
		pass
```

```gdscript
# onready means the variable will be assigned after nodes are loaded completely
onready var SomeNode = $Label 
```

- queue_free(), reload_current_scene()

```gdscript
# changing node visibility
PlayerText.visible = false # true to show
# or
PlayerText.hide() # .show() to show
```

```gdscript
# getting rid of node from memory
PlayerText.queue_free()
```

```gdscript
# get entire scene tree
get_tree()

# Reloads the currently active scene.
get_tree().reload_current_scene()
```

- Dictionary

Key-value pairs.
```gdscript
var template = [
		{
			"prompts": ["a name", "a noun", "adverb", "adjective"],
			"story": "Once upon a time someone called %s ate a %s flavored sandwich which made him feel %s inside. It was a %s day.",
		},
		{
			"prompts": ["a noun", "a name", "adjective", "another name"],
			"story":"There once was a %s called %s who searched far and wide for mythical %s noun of %s"
		},

func set_current_story():
	randomize() # suffle the random number using time so that randi() is different everytime
	current_story = template[randi() % template.size()]
```


- Inspector Tab

We can manage the property of nodes in it

Rect to cahnge position, size, minSize,  
Custom Font to add a new dynamic font where custom font can be added.  

Size Falgs to expand, fill, shrink,cent, shrink,e nd used with HboxContainer and VboxContainer childs


- Node Tab

Signals\Listeners can be added to a certain node. When certain thing happens on one node, it sends signals to the connected node where we can do things related to that specific signal through script attached to receiving node.


