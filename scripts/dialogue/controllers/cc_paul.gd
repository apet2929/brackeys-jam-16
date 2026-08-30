class_name PaulCutsceneController
extends CutsceneController

func _init():
	self.current_cutscene = PaulCutscene0.new()
	self.next_cutscene = self.current_cutscene

func display_next():
	await super.display_next()
	
	if self.current_cutscene.last_response != null:
		if self.current_cutscene.last_response.ending == "accused":
			Globals.main.accuse("Paul")
		if self.current_cutscene.last_response.ending == "origin_revealed":
			Globals.knows_origin = true
		if self.current_cutscene.index == 0:
			if self.current_cutscene.last_response.ending == "drunk":
				self.next_cutscene = PaulCutsceneDrunk.new()
			else:
				self.next_cutscene = PaulCutscene1.new()
		super.advance_cutscene()
