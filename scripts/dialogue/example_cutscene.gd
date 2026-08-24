class_name ExampleCutscene
extends Cutscene

func _init() -> void:
	var player_dialogue_scene = load("res://scenes/player_dialogue_scene.tscn")
	self.dialogue_root = SpeakerLines.new("Xander", 
		[
			"They may or may not be in my walls",
			"What do you think? Are they?"
		]
	)
	var after_response_1 = SpeakerLines.new("Xander", ["Well thanks for nothing"])
	var after_response_2 = SpeakerLines.new("Xander", ["You're in with them too..."])
	var after_response_3 = SpeakerLines.new("Xander", ["The Sahara."])
	self.dialogue_root.response_options = [
		SpeakerLines.Response.new("I'm not sure how to respond to that", after_response_1),
		SpeakerLines.Response.new("They most certainly are.", after_response_2),
		SpeakerLines.Response.new("Where were you on the night of September 15th, 2024?", after_response_3)
	]
	
	after_response_3.next_line = SpeakerLines.new("You",
		[
			"Bullshit, I know who you are.",
			"Don't think you can fool me"
		],
		player_dialogue_scene
	)
