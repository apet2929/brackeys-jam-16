class_name ShirleyCutsceneController
extends CutsceneController

func _init():
	self.current_cutscene = ShirleyCutscene0.new()
	self.next_cutscene = self.current_cutscene

func display_next():
	await super.display_next()
	
	if self.current_cutscene.last_response != null:
		if self.current_cutscene.last_response.ending == "accused":
			Globals.main.accuse("Shirley")
		if self.current_cutscene.last_response.ending == "effects_revealed":
			Globals.knows_happy_effects = true
			print("SET HAPPY EFFECTS")
		super.advance_cutscene()
