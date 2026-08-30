class_name GregoryCutsceneController
extends CutsceneController

func _init():
	self.current_cutscene = GregoryCutscene0.new()
	self.next_cutscene = self.current_cutscene

func display_next():
	await super.display_next()
	
	if self.current_cutscene.last_response != null:
		if self.current_cutscene.last_response.ending == "accused":
			Globals.main.accuse("Gregory")
		if self.current_cutscene.last_response.ending == "aliens_revealed":
			print("ALIENS")
			Globals.knows_aliens = true
		if self.current_cutscene.index == 0:
			if Globals.knows_happy_effects:
				self.next_cutscene = GregoryCutsceneHappy.new()
		super.advance_cutscene()
