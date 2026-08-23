extends Node

# Globals- Put stuff you want to be easily accessible here
var hp = 0 # e.g. you can access this from anywhere Globals.hp
signal on_hit # signals are the Listener pattern for Godot  used to pass messages around, use them extensively to decouple classes and stuff
 # use Main to 
@onready var main: Main
@onready var ui: UI
# This is an autoload singleton. 
# Globals will be automatically inserted as a child of the scenetree root 
# You can add a Global script via Project > Project Settings > Globals

# setup that runs before nodes are inserted into the tree
func _init():
	pass
	
# setup that runs after this node is inserted into the tree
func _ready():
	main = get_tree().root.find_child("Main", true, false)
	ui = get_tree().root.find_child("UI", true, false)
	self.call_deferred("_after_ready")
	
	print(main)
	print(ui)
	pass
	
# setup that runs after all nodes have been inserted into the tree
func _after_ready():
	pass
