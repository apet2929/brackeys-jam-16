class_name Cutscene
extends Resource

var dialogue_root: SpeakerLines = null
var player_dialogue_scene_name = "res://scenes/player_dialogue_scene.tscn"
var player_dialogue_scene = null
var last_response: SpeakerLines.Response = null
# Index of cutscene in sequence to differentiate cutscenes for an NPC
var index = 0

func _ready():
	player_dialogue_scene = load(player_dialogue_scene_name)

func _on_dialogue_response(response: SpeakerLines.Response):
	# Track the current path of the conversation
	last_response = response

func display():
	Globals.ui.dialogue_response_selected.connect(_on_dialogue_response)
	self.update()
	dialogue_root.display()

func update():
	pass
