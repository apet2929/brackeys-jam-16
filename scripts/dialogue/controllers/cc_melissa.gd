class_name MelissaCutsceneController
extends CutsceneController

func _init():
	self.current_cutscene = MelissaCutscene0.new()
	self.next_cutscene = self.current_cutscene

func display_next():
	await super.display_next()
	
	super.advance_cutscene()
