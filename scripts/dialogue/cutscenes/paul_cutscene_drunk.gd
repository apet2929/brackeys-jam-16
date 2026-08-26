class_name PaulCutsceneDrunk
extends Cutscene

func _init() -> void:
	self.index = 2
	self.dialogue_root = SpeakerLines.new("Paul", 
		[
			"Poison gas?",
			"I dunno wha’ you’re talkin’ about.",
			"uuuuugggghhhhh"
		]
	)
