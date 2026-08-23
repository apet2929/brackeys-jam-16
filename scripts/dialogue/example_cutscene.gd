class_name ExampleCutscene
extends Cutscene

func _init() -> void:
	var player_dialogue_scene = load("res://scenes/player_dialogue_scene.tscn")
	self.dialogue_root = SpeakerLines.new("Xander", 
		[
			"They may or may not be in my walls",
			"What do you think?"
		]
	)
	self.dialogue_root.add_response(
		SpeakerLines.new("You", ["I'm not sure how to respond to that."], player_dialogue_scene)
	).add_response(
		SpeakerLines.new("Xander", ["Well thanks for nothing"])
	)
