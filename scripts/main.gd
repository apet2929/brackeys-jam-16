class_name Main
extends Node3D

# It's common to have 1 root scene that contains the current level
# and anything that should be persisted between levels
# the Main instance can be found via Globals.main

@export var level_scene = preload("res://scenes/level1.tscn")
@onready var current_level

func _ready() -> void:
	current_level = level_scene.instantiate()
	#self.add_child(current_level)
