extends RigidBody3D

@export var Item : PackedScene
@export var do_cutscene = false
var cutscene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if do_cutscene:
		cutscene = ExampleCutscene.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact() -> void:
	print("box interacted, no clowns inside")
	if do_cutscene:
		cutscene.display()
