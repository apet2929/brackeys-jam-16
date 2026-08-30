extends Node

var knows_origin: bool = false
var knows_happy_effects: bool = false
var knows_aliens: bool = false

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
	initialize()
	
# setup that runs after all nodes have been inserted into the tree
func _after_ready():
	pass

func initialize():
	var root_node = get_tree().current_scene
	if root_node is Main:
		main = get_tree().current_scene
		ui = get_tree().root.find_child("UI", true, false)
		self.call_deferred("_after_ready")
		
		print(main)
		print(ui)

# Update the UI to un-redact dossier info based on our 3 "knows" bools
func update_dossier():
	pass
