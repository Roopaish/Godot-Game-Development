# Godot Game Development

Games made with [Godot Engine](https:#godotengine.org/), free and open-source game engine.

- [Loony Lips - Discovering GDScript](#loony-lips---discovering-gdscript)  
  [Play Online](https://roopaish.github.io/Godot-Game-Development/Loony%20Lips/exports.html) [Download for Windows](https://github.com/Roopaish/Godot-Game-Development/releases/tag/exe)
- [Hoppy Days - Discovering the Engine](#hoppy-days---discovering-the-engine)
- Heist Meisters - Top-Down-Stealth
- CubeDude Kickabout - 3D Local Multiplayer
- Food Fight - Advanced 3D

## Loony Lips - Discovering GDScript

- ### Theme

A Word game,Ask for a word based on type(nouns, verb, etc)Then plug the words into expandable template for stories

- ### Basics and Arrays

Godot is comprised of nodes. Nodes can have children. It's just like Widgets of Flutter.
NodeName are named like this: LoonyLips;

```gd
# inherits properties of Control node (class), it get automatically added when attaching script to a node (Control in this case)
extends Control

# _ready() function run at start like a main() fxn in C++

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
# Output

Hello Yann
Hello Someone else
Once upon a time Yann watched Minions and thought is was the Greatest movie of the past two decades
Once upon a time Izabella watched Dune and thought is was the Biggest movie of the past two
```

- ### Inspector Tab

We can manage the property of nodes in it. All these property can be accessed and changed with script.

Rect to change position, size, minSize.

Custom Font to add a new dynamic font where custom font can be added.
Use settings to change font size, use filter to make edges blurry instead of pixilated.
Custom Color to give font color and so on.

Size Flags to expand, fill, shrink,cent, shrink,e nd used with HBoxContainer and VboxContainer children

Transform for position, rotation and scale of the node.

Visibility -> Modulate to change color of node.

- ### Node Tab

Signals\Listeners can be added to a certain node. When certain thing happens on one node, it sends signals to the connected node where we can do things related to that specific signal through script attached to receiving node.

- ### TextureRect, Label

`TextureRect node for background`
Drag background to Texture in Inspector. Press play, when resizing the window, it looks like the background is cutting but not expanding.
So go back and click on expand. Changes won't be reflected on the editor, so add a new scene and come back to the previous scene, changes will be reflected and the background will look small.

Click on the node -> Layout -> Anchors only -> Full rect to measure the bounding rectangle(screen) so it knows where to expand.
Now click node -> Layout -> Full Rect. Now the texture will cover the full rectangle and will shrink and expand on changing screen sizes.

Change default size of the window, Project -> Project Setting -> General -> Window -> Under Size

`label node is used display something on the screen`
Custom fonts can be added by creating new dynamic font from inspector, margin, auto-wrap etc can be done.

```gd
# Access the child node
# Hover over the Properties of Node in Inspector to know the property name of it, so we can access them using . operator
# We can also drag Node to script to access the path along its name (Label in this case)
get_node("Label").text = "Changed Text"
$Label.text = "Another Changed Text"

# Use "" to access node with space in its name
# However its not a convention to do so
$"Label Name".text = "Text for label name"

# Showing Story to screen
var prompts = ["Yann", "Minions", "Greatest"]
var story = "Once upon a time %s watched %s and thought is was the %s movie of the past two decades"

$DisplayText.text = story % prompts
```

There's RichLabelText which is like Label but we can make certain part of text underlined, bold etc.(Bb code) And It is scrollable, if it doesn't fit

- ### LineEdit, VBoxContainer, HBoxContainer, TextureButton

Getting text from Player
`LineEdit is for single line input` and `TextEdit for multi line input`

```gd
# shift focus to the LineEdit, so that we can start typing immediately
func _ready():
	LineEdit.grab_focus()
```

`VBoxContainer to align nodes in row` and `HBoxContainer to align nodes in column`
We can change alignment, margins etc

Select LineEdit, In node tab, click text_entered and connect to first node where script is attached

```gd
# This fxn will get automatically added
func _on_PlayerText_text_entered(new_text):
	pass # Replace with function body.
	$Label.text = new_text
	# entered text will be shown in the screen
	LineEdit.clear() # to clear the entered text from LineEdit
```

`TextureButton to make a button with textures`
Here TextureButton and LineEdit are placed in HBoxContainer. LineEdit -> Size Flags -> Expand (so it will expand to available space).

TextureButton -> Rect -> Set the proper size to match the look of LineEdit. This will set the size of Node not the texture. TextureButton -> Turn expand on (it will vanish) , now go to Rect and give the node a minimum size. Everything will work now.

HBoxContainer and VBoxContainer has Custom Constants -> Separation property to set the spacing between child nodes.

```gd
# Changing screen's text when button is pressed
func _on_TextureButton_pressed():
	var new_text = $VBoxContainer/HBoxContainer/LineEdit.text
	update_Label(new_text)

```

- ### array methods and if-else

```gd
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

```gd
# onready means the variable will be assigned after nodes are loaded completely
onready var SomeNode = $Label
```

- ### Node methods

```gd
# changing node visibility
PlayerText.visible = false # true to show
# or
PlayerText.hide() # .show() to show
```

```gd
# getting rid of node from memory
PlayerText.queue_free()
```

```gd
# get entire scene tree
get_tree()

# Reloads the currently active scene.
get_tree().reload_current_scene()
```

- ### Dictionary

Key-value pairs.

```gd
var template ={
		"prompts": ["a name", "a noun", "adverb", "adjective"],
		"story": "Once upon a time someone called %s ate a %s flavored sandwich which made him feel %s inside. It was a %s day.",
		}
```

- ### Dynamic and Typed gdscript

In dynamic gdscript, variable can change. variable can be string at one time, array at another and so on.
Typed gdscript is opposite of dynamic gdscript.

```gd
# : PoolStringArray we are making gdscript typed, so that only String will be stored in the array
export var prompts : PoolStringArray
export var story : String # Accepts string only

# export is for making the variable available in inspector tab, So even if script is same, the variable's value for each node can be different
func set_current_story():
	randomize() # shuffle the random number using time
	var stories = $StoryBook.get_child_count() # getting number of children
	var selected_story = randi() % stories # randi() returns random integer
	current_story.prompts = $StoryBook.get_child(selected_story).prompts # Accessing child based on index
	current_story.story = $StoryBook.get_child(selected_story).story
```

We can make a Storybook with 'Node' node which doesn't have much properties to add children nodes 'Node' which will contain each story.However, its not quite efficient if player wants to add a new story and also its a lot of work to add each variable values one by one.

- ### JSON

JavaScript Object notation, like a dictionary.
It can't be opened in godot, so other editors are required.
Pros of JSON:
Good code
Easy to mod game

```gd
# Reading file from json
func get_from_json(filename):
	var file = File.new() # new file object
	file.open(filename, File.READ) # open in read mode
	var text = file.get_as_text() # get the file text
	var data = parse_json(text) # change text to json
	file.close() # close the file
	return data
```

- ### Exporting the game

Project -> Export -> Add -> Windows Desktop
If export template not available already, Click Manage Export Template -> Download -> Click on the lick provided. Download will start now.

Now click close it and click Project -> Export -> Add -> Windows Desktop -> choose location and export

## Hoppy Days - Discovering the Engine

- ### Theme

2d Platformer, Get bunny to the destination.
Essential Experience:

1. Cute
2. Speed and Agility
3. Dangerous world

GamePlay Factors:

1. No player attacks
2. Limited Lives
3. Fast Movement, high jumps
4. can get more lives with enough coins

- ### PhysicsBody2D

Object that interacts with physics engine.  
Types:  
`StaticBody2D` -> No movement, simple velocity applied. Example: walls, floors, platforms etc.  
`RigidBody2D` -> Controlled by 2D engine, built-in behaviors like gravity, friction. Example: football.
Not Controlled directly, forces are applied to it.  
`KinematicBody2D` -> Controlled by player, not affected by 2D physics engine, can be moved directly with control. Example: Player.

1. KinematicBody2D

Needs a CollisionShape2D, so it knows the outline of the shape. We can add a Sprite to it, so that we can add a CollisionShape2D around it, to make it a KineticBody.

> Tip: Select a parent node, select 'make sure the object's children are not selectable' located next to lock icon. So now we can move the whole KineticBody2D.

Map keys from Project -> Project Settings -> Input Map.  
We can add a action and then add keys or any input to trigger that action.  
Suppose, we add 'left' action and mapped it to 'A' key.  
Now hitting 'A' will trigger 'left' action which can be used in script as `if Input.is_action_pressed("left"):`

```gd
# Players Movement
extends KinematicBody2D

var motion = Vector2() # 2D array with x and y values, used for positions

const SPEED = 500

# _physics_process is a fxn to run code for every frame, and also to do physics stuffs
# delta is the time in seconds between frames
# multiplying by delta means that the values will be same even if the frame rate changes
func _physics_process(delta):
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED # -ve x-axis
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED # +ve x-axis
	else:
		motion.x = 0 # stop
	move_and_slide(motion) # move and slide the Player by given position
```

`move_and_collide()` -> when you hit something, stop | can get collision info whenever it hits | doesn't automatically use delta  
`move_and_slide()` -> when you hit something, try and move it | can detect floors, ceilings and walls | automatically use delta

> Making CollisionShape2D cover up whole sprite

- CollisionShape2D => If we have a sprite of 32x32 size and we scaled it by 10x10, then the total size of sprite will be 320x320 in pixel. Now For CollisionShape2D, we should have scale or extents of 320x320, so to cover up the sprite.

> Axis in Godot

- In godot, the center of axis is at top-left corner. So downwards is +ve y, upwards is -ve y, left is +ve x and right is -ve x.

> Adding a scene as an instance in another scene

Create a new scene, Press `ctrl+shift+a` to choose any saved scene as an instance. So, now instantiated scene's properties can be used. Also everything is reflected to the instantiated scene if any changes is made in the original scene.

> Make bunny jump and apply gravity

```gd
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
	move_and_slide(motion, UP) # Second argument is used to trigger is_on_floor()

# Keep on increasing down position(gravity or down speed), only if the sprite is not on the floor
func apply_gravity():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		# is_action_just_pressed will trigger only once, even if we hold jump key for too long
		# is_action_pressed, will work fine here, cause we are checking if it is in floor, before applying jump
		motion.y -= JUMP_SPEED
```

> Animated Sprite

Add AnimatedSprite -> In inspector Tab -> Create New SpriteFrames under Frames property -> Click on it -> Animation Panel will appear at bottom

Under Animations: There will be a default animation, change the name as you will.  
You can add new animations and name them as you will. By selecting the animation, drag animation frames(sprites) to Animation Frames:  
In Inspector tab, turn on Playing, now the animation will happen.

```gd
# We can reference those animations we created with their names
func animate():
	if motion.y < 0:
		$AnimatedSprite.play('jump') # play jump when moving up
	elif motion.x > 0:
		$AnimatedSprite.play('walk')
		$AnimatedSprite.flip_h = false
	elif motion.x < 0:
		$AnimatedSprite.play('walk')
		$AnimatedSprite.flip_h = true # flip horizontally when moving to left
	else:
		$AnimatedSprite.play('idle')

func _physics_process(delta):
	...
	animate()
```

> Tips for Elegant Code

    - easy to read by human
    - do not have multiple scripts working on the same thing
    - do not have one script doing multiple things
    - Encapsulate: If a node or function is missing, the game should work just fine

Even if we remove a piece of code, or a node, the game should work fine without causing any errors. This can be achieved by encapsulating each node with its own script.  
It means if we add some functionalities to a particular node, its better to make its own scene with a separate script attached to it where functionalities are defined.

> Encapsulating

PlayerAnimation(AnimatedSprite) is child of Player. Right click on it -> Save Branch as Scene.
Now, PlayerAnimation becomes a separate scene. Attach a script to it eg:PlayerAnimation.gd.

```gd
# Player.gd
signal animate

func _physics_process(delta):
	...
	animate()

func animate():
	# emitting signal called animate (which will be available in node tab when player is selected)
	emit_signal("animate", motion) # emitting signal animate and passing motion(position of player)
```

Connect animate() to PlayerAnimation.gd

```gd
# PlayerAnimation.gd
# Using that motion to play different animation
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
```

Now, PlayerAnimation and Player are encapsulated.

> TileMaps

Create a new scene and add a node2d to group all sprites. Drag and drop sprites needed.
In each sprite add a StaticBody2D with CollisionPolygon2D(to get the exact size of tiles).

Click on Scene -> Covert to -> Tileset -> save it as .tres file  
Also save the scene.

Now we can use these tileset on any scenes, just add a TileMaps node, and load this file.

> Collision

The layers are like enum, we can name them thorough Project -> Project Settings -> General -> 2D physics

Collision Layers: which layers we exist on
Collision Masks: which layers we can interact with

> Camera2D

Properties:  
Current -> If enabled, camera will follow the moving object  
Drag Margin H Enabled -> If enabled, the camera will follow after a while when moving left and right  
Drag Margin V Enabled -> same but for up and down  
Smoothing -> Smooth transition of camera  
Limit -> Set Limit to which the camera/player can move

> is_on_ceiling()

This is updated every time move_and_slide() is called. Just like is_on_floor(), we are telling that if player touches the ceiling, set the y position to 1 i.e. 1px below ceiling.

```gd
if is_on_ceiling():
	motion.y = 1 # To make Player bouncing, if the ceiling is hit rather than hovering
	# It takes the Player and move it down to 1 px, if ceiling is hit
```

> Parallax Backgrounds

Closer layer is faster, and the faster the layer moves, the faster the player will feel like they're going.

So we create it like this, Camera2D > ParallaxBackground > ParallaxLayer > TextureRect(contains texture for background). ParallaxBackground contains all ParallaxLayers.

To repeat the layer:  
Find the size of the texture used, then under ParallaxLayer -> motion -> mirroring -> paste the size of texture. Now the texture will be repeated. Now select ParallaxBackground and turn on `ignore camera zoom`. This will make sure that every layer is completely covering the screen.

We can also offset the ParallaxLayers and turn of mirroring by using value 0.  
Scale is used for changing speed of the layers.  
We can also manage these whole things under ParallaxBackground which will affect all.

> CenterContainer

To center any child node inside it.

> change_scene

```gd
get_tree().change_scene("res://Levels/GameOver.tscn")
```

> Area2D

Part of game world that can detect when things are entering and leaving.
It always has a CollisionShape.  
Connect signal body_entered to the script. Now the generated function will execute whenever any particular node touches Area2D.  
We can setup collision layers and masks to detect any interaction.

```gd
# Detect collision to Area2D, if collision layers and masks are setup
extends Area2D

func _on_Area2D_body_entered(body):
	print('Player hit the spikes')
```

```gd
# Detect collision to Area2D, if collision layers and masks are not setup
extends Area2D

func _on_Area2D_body_entered(body):
	if body.name == "Player": # or if body is Kinematic2D
		print('Player touched Area2D')
```

```gd
# Execute method of the body that touched Area2D
func _on_Area2D_body_entered(body):
	if body.has_method("hurt"): # To check if the body already has a method, necessary only if collision layers are not setup
		body.hurt()
```

> yield

```gd
yield(get_tree(),"idle_frame") # wait for a frame
```

> AudioStreamPlayer

AudioStreamPlayer plays throughout the game.  
AudioStreamPlayer2D plays as you get closer.  
AudioStreamPlayer3D plays as you get closer but in 3D.

```gd
# Load audio through script and play
$AudioStreamPlayer.stream = load("res://SFX/pain.ogg")
$AudioStreamPlayer.play()

# Same node can be used to play different sounds
$AudioStreamPlayer.stream = load("res://SFX/jump.ogg")
$AudioStreamPlayer.play()
```

> AnimationPlayer

AnimationPlayer helps in creating animation that can be customized with keyframes and can be executed through script. We can create an animation and name it. Then we can add tracks which deals with animating certain aspects of a particular node. Property track is most common. We need to select which node we want to animate then which property of it. Then we can insert keys by right clicking on the track.

```gd
# Controlling Animation of AnimatedSprite
# In the inspector tab we can set which animation from AnimatedSprite to animate or make it a key
# Play animation named boost
$AnimationPlayer.play("boost")
```

