class_name MelissaCutscene0
extends Cutscene

func _init() -> void:
	super._ready()
	self.index = 0
	self.dialogue_root = SpeakerLines.new("Melissa", 
		[
			"What do you want."
		]
	)
	var line_1 = SpeakerLines.new("Melissa", ["I don't talk to the press. Please reach out to my communications team for comment."])
	var line_2 = SpeakerLines.new("Melissa", ["Ah, my apologies. It's been a long night. It's a pleasure to meet you.", 
											  "You know, I'll be running against that oaf Gregory for his representative position next month. Can I count on your support?"])
	var line_3 = SpeakerLines.new("Melissa", ["Sorry, but I already have a quite dedicated campaign manager of my own."])
	self.dialogue_root.response_options = [
		SpeakerLines.Response.new("Calm down, I'm just another reporter. What brings you to this party?", line_1),
		SpeakerLines.Response.new("Sorry if I'm bothering you. I'm Michael. I own the city's steel plant.", line_2),
		SpeakerLines.Response.new("Excuse me, are you Melissa Machiavelli? I'm a campaign manager for some of the state's representatives and I'd be interested in speaking with you.", line_3)
	]
	if Globals.accusable():
		self.dialogue_root.response_options.append(SpeakerLines.Response.new("I know you're the leaker Melissa, you're coming with me.", SpeakerLines.new("Melissa", ["Leaker? What the hell are you talking about? Get away from me!"]), "accused"))
	
	
	line_1.next_line = SpeakerLines.new("You", ["Damn."], self.player_dialogue_scene)
	
	line_2.response_options = [
		SpeakerLines.Response.new("Certainly. Have you heard any rumors that might hit the news soon?", SpeakerLines.new("Melissa", ["Nothing in particular, no. I appreciate your support, but I really must be going now."])),
		SpeakerLines.Response.new("Are you planning on tax cuts?", SpeakerLines.new("Melissa", ["I'm not running on the same platform as my predecessor, as much as I'm sure you sharks would appreciate it. Do as you wish, but I'm going to win regardless. Just look at what happened to Gregory, do you really think he can stand a debate?"]))
	] as Array[SpeakerLines.Response]
	
	var handled = SpeakerLines.new("Melissa", ["Frankly, I'm running for what I believe in above all else. Whether I succeed or fail, trying to fight for what I believe in will always be worth it.",
											   "Besides, have you seen Gregory today? He's been dealt with."])
											
	handled.response_options = [
		SpeakerLines.Response.new("Oh, I see. Well, best of luck in the election. I'll get in contact soon.", null),
		SpeakerLines.Response.new("What do you mean \"dealt with\"? Who orchestrated such a thing?", SpeakerLines.new("Melissa", ["Look, I don't know okay? Stop your prodding."]))
	] as Array[SpeakerLines.Response]
	
	line_3.response_options = [
		SpeakerLines.Response.new("I believe you misunderstand me. I'm not looking to advertise myself, I'm moreso looking for a partnership and info on your campaign. My clients were rather shocked to see you run against such a popular incumbent. What's your strategy?", handled)
	] as Array[SpeakerLines.Response]
	
