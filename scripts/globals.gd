extends Node

var knows_origin: bool = false:
	set(value):
		knows_origin = value
		main.update_dossier(knows_origin, knows_happy_effects, knows_aliens)
var knows_happy_effects: bool = false:
	set(value):
		knows_happy_effects = value
		main.update_dossier(knows_origin, knows_happy_effects, knows_aliens)
var knows_aliens: bool = false:
	set(value):
		knows_aliens = value
		main.update_dossier(knows_origin, knows_happy_effects, knows_aliens)

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

func accusable() -> bool:
	return knows_origin && knows_happy_effects && knows_aliens
