class_name PaulCutscene0
extends Cutscene

func _init() -> void:
	super._ready()
	self.index = 0
	self.dialogue_root = SpeakerLines.new("Paul", 
		[
			"Hey, how's it going.",
			"Not too shabby of a party, huh?"
		]
	)
	var line_1 = SpeakerLines.new("Paul", ["You should see what else these people blow our money on. Some of it sounds closer to insanity than helping the public."])
	var line_2 = SpeakerLines.new("Paul", ["You bet. I'm with the New York Paper so they shuttle me around to all these fancy events. Bores me half to death. My coworker Shirley still enjoys these but there's only so many you can take before it all looks the same."])
	var line_3 = SpeakerLines.new("Paul", ["Hah, I could use another drink after all this meaningless chatter. Hopefully this will be the one that knocks me out."])
	self.dialogue_root.response_options = [
		SpeakerLines.Response.new("Talk about a good use of tax dollars.", line_1),
		SpeakerLines.Response.new("I've seen better. You come to these things often?", line_2),
		SpeakerLines.Response.new("I'll know if it's a good party or not once I try the wine. Care to join me?", line_3, "drunk")
	]
	
	var origin_reveal = SpeakerLines.new("Paul", ["Oh yeah, you bet. We're planning a big story about some sort of a chemical weapon out of a North Carolina lab. Part of the reason I'm here is to build connections for when we start interviewing people for comments."])
	origin_reveal.response_options = [
		SpeakerLines.Response.new("Thanks for the info man, and good luck with the story.", SpeakerLines.new("Paul", ["Anytime. Just make sure to pick up our paper come Monday."]), "origin_revealed")
	] as Array[SpeakerLines.Response]
	
	line_1.response_options = [
		SpeakerLines.Response.new("I get what you mean. Any incidents of note recently?", SpeakerLines.new("Paul", ["Nope, or at least not anything I can say before publishing, haha."])),
		SpeakerLines.Response.new("Have you heard anything about some sort of secret project getting leaked to the public?", origin_reveal)
	] as Array[SpeakerLines.Response]
	
	line_3.next_line = SpeakerLines.new("Narrator",
		[
			"You pick up two glasses of wine off the nearby table, handing one to Paul.",
			"It tastes bitter, probably too expensive for your tastes."
		],
		self.player_dialogue_scene
	)
	
	line_3.next_line.next_line = SpeakerLines.new("Paul",
		[
			"Heh, thanks for that one.. See you aroun' man *hiccup*."
		],
		self.player_dialogue_scene
	)
	
