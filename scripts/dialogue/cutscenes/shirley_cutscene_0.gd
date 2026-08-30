class_name ShirleyCutscene0
extends Cutscene

func _init() -> void:
	super._ready()
	self.index = 0

func update():
	self.dialogue_root = SpeakerLines.new("Shirley", 
		[
			"Pleasure to meet you, my name's Shirley with the New York Paper!"
		]
	)
	var line_1 = SpeakerLines.new("Shirley", ["You know, gotta get caught up on all the gossip! You never know, there might be a scandal right under our noses..."])
	var line_2 = SpeakerLines.new("Shirley", ["Well, I just joined recently so I'm not terribly sure. I graduated from college just a few months ago!"])
	self.dialogue_root.response_options = [
		SpeakerLines.Response.new("Nice to meet you Shirley. What brings you to this party?", line_1),
		SpeakerLines.Response.new("The paper huh. Any interesting stories lately?", line_2),
	]
	if Globals.accusable():
		self.dialogue_root.response_options.append(SpeakerLines.Response.new("I know you're the leaker Shirley, you're coming with me.", SpeakerLines.new("Shirley", ["Uh what? I haven't even covered any stories yet, how could I leak anything?"]), "accused"))
	
	var worthless = SpeakerLines.new("Shirley", ["You probably could've guessed, it's just journalism. I'm hoping to get some good use out of it, but these people don't have much information.", 
												 "The only people who haven't brushed me off are Gregory and you, but I'm preeeetty sure Gregory is crazy."])
	worthless.response_options = [
		SpeakerLines.Response.new("That's a shame. Keep trying and I'm sure you'll get somewhere. Try offering one of the old guys a beer and they'll crack like a coconut.", SpeakerLines.new("Shirley", ["Hah, thanks for the advice! I'll give it a shot."])),
		SpeakerLines.Response.new("You think that Gregory guy is always like that?", SpeakerLines.new("Shirley", ["No, he's actually a representative and a fairly verbose one at that. His behavior is really strange, it's like he's been infected with something"]), "effects_revealed")
	] as Array[SpeakerLines.Response]
	
	line_2.response_options = [
		SpeakerLines.Response.new("Ah, I see. Sorry for bothering you.", SpeakerLines.new("Shirley", ["If you find any juicy stories, let me know! I'm sure there's SOMETHING interesting here."])),
		SpeakerLines.Response.new("Congratulations. What's your degree in?", worthless)
	] as Array[SpeakerLines.Response]
