class_name GregoryCutsceneHappy
extends Cutscene

func _init() -> void:
	super._ready()
	self.index = 1

func update():
	self.dialogue_root = SpeakerLines.new("Gregory", 
		[
			"HAHAHAHAHA"
		]
	)
	var line_1 = SpeakerLines.new("Gregory", ["Hell YEAH I did. It's called METH BABY."])
	var line_2 = SpeakerLines.new("Gregory", ["The aliens. They landed in my backyard in North Carolina. Slippery snakes got away before I could gun them down. Let them try me again. SEE WHAT HAPPENS!!!", 
											  "Their NASTY spaceship left a cloud of dust everywhere and I just haven't stopped laughing since hahahahaha."])
	var line_3 = SpeakerLines.new("Narrator", ["Probably for the best."], self.player_dialogue_scene)
	self.dialogue_root.response_options = [
		SpeakerLines.Response.new("Gregory, I need you to listen to me. Did you get injected with anything recently?", line_1),
		SpeakerLines.Response.new("What's up Gregory. Did you see anything cool lately? Maybe government agents?", line_2),
		SpeakerLines.Response.new("Yeah nevermind I'm not dealing with this", line_3)
	] as Array[SpeakerLines.Response]
	
	if Globals.accusable():
		self.dialogue_root.response_options.append(SpeakerLines.Response.new("I know you're the leaker Gregory, you're coming with me.", SpeakerLines.new("Gregory", ["HAHAHAHAHHAA!!! IDIOT!!!"]), "accused"))
	
	line_2.response_options = [
		SpeakerLines.Response.new("That's rough man, I'm sorry. I really am.", SpeakerLines.new("Gregory", ["wine time"]), "aliens_revealed")
	] as Array[SpeakerLines.Response]
	
