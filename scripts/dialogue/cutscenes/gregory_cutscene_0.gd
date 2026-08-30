class_name GregoryCutscene0
extends Cutscene

func _init() -> void:
	super._ready()
	self.index = 0
	self.dialogue_root = SpeakerLines.new("Gregory", 
		[
			"HI BUDDY!"
		]
	)
	var line_1 = SpeakerLines.new("Gregory", ["What's up man, you look a little nervous. This is a party, don't you know it? Get DRUNK."])
	var line_2 = SpeakerLines.new("Gregory", ["The name's GREGORY. That's G for GREATEST REPRESENTATIVE ALIVE!!!!"])
	var line_3 = SpeakerLines.new("Gregory", ["Never better, haha. You have GOT to try the wine it's absolutely FABULOUS."])
	self.dialogue_root.response_options = [
		SpeakerLines.Response.new("Hey...", line_1),
		SpeakerLines.Response.new("Nice to meet you, I suppose. What's your name?", line_2),
		SpeakerLines.Response.new("Are you feeling alright?", line_3)
	]
	if Globals.accusable():
		self.dialogue_root.response_options.append(SpeakerLines.Response.new("I know you're the leaker Gregory, you're coming with me.", SpeakerLines.new("Gregory", ["HAHAHAHAHHAA!!! IDIOT!!!"]), "accused"))
	
	line_1.response_options = [
		SpeakerLines.Response.new("I, uh, appreciate the advice. Buddy.", SpeakerLines.new("Gregory", ["You better appreciate it. None of us will make it through the night without a few drinks"]))
	] as Array[SpeakerLines.Response]
	
	line_3.next_line = SpeakerLines.new("You",
		[
			"I think it'd be better if we cut you off for the night."
		],
		self.player_dialogue_scene
	)
	
