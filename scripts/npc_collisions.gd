extends Area3D
@onready var npc = $".."

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(other):
	if other is Player:
		npc.colliding_player = other

func _on_body_exited(other):
	if other is Player:
		npc.colliding_player = null
