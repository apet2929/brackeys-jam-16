class_name PaulCutscene1
extends Cutscene

func _init() -> void:
	self.index = 1
	self.dialogue_root = SpeakerLines.new("Paul", 
		[
			"Nice to see you again.",
			"Already talk to everyboady interesting here? I have nothing of interest left for you."
		]
	)
