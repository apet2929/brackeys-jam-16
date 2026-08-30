class_name MelissaCutsceneController
extends CutsceneController

func _init():
	self.current_cutscene = MelissaCutscene0.new()
	self.next_cutscene = self.current_cutscene

func display_next():
	await super.display_next()
	
	if self.current_cutscene.last_response != null:
		if self.current_cutscene.last_response.ending == "accused":
			Globals.main.accuse("Melissa")
			
	super.advance_cutscene()
