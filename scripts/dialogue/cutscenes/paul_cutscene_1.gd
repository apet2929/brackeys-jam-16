class_name PaulCutscene1
extends Cutscene

func _init() -> void:
	self.index = 1

func update() -> void:
	self.dialogue_root = SpeakerLines.new("Paul", 
		[
			"Nice to see you again.",
			"Already talk to everyboady interesting here? I'm just want to go back home already."
		]
	)
	var effects_line = SpeakerLines.new("Paul", ["Laughing gas, you say? Can't say I've quite heard of it, but that might be an interesting theory to another story I'm working on. Rumor has it, a chemical weapon is being built in a lab in North Carolina. It's a valuable story to me since my family lives back there. I visit them all the time and couldn't fathom a chemical attack over there."])
	var aliens_line = SpeakerLines.new("Paul", ["Haha, no clue on that front. I haven't seen any aliens myself but I do wish they'd come around and beam up my wife already."])
	self.dialogue_root.response_options = []
	if Globals.knows_happy_effects:
		self.dialogue_root.response_options.append(SpeakerLines.Response.new("Have you heard anything about a lethal version of laughing gas? I figure your media connections might still have something.", effects_line))
	if Globals.knows_aliens:
		self.dialogue_root.response_options.append(SpeakerLines.Response.new("I've heard there was some sort of an alien spacecraft that landed out West. Any veracity to that claim or is it just hillbilly tales?", aliens_line))
	if Globals.accusable():
		self.dialogue_root.response_options.append(SpeakerLines.Response.new("I know you're the leaker Paul, you're coming with me.", SpeakerLines.new("Paul", ["Fine. Take me away. It won't save you from the truth that will be revealed"]), "accused"))
	
	effects_line.response_options = [
		SpeakerLines.Response.new("Thanks for the info man, and good luck with the story.", SpeakerLines.new("Paul", ["Anytime. Just make sure to pick up our paper come Monday."]), "origin_revealed")
	] as Array[SpeakerLines.Response]
