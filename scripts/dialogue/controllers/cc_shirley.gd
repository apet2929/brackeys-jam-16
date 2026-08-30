class_name ShirleyCutsceneController
extends CutsceneController

var shown_aliens: bool = false
var shown_effects: bool = false

func _init():
	self.current_cutscene = ShirleyCutscene0.new()
	self.next_cutscene = self.current_cutscene

func display_next():
	await super.display_next()
	
	if self.current_cutscene.last_response != null:
		if self.current_cutscene.last_response.ending == "origin_revealed":
			Globals.knows_origin = true
		elif self.current_cutscene.index == 0:
			if self.current_cutscene.last_response.ending == "drunk":
				self.next_cutscene = PaulCutsceneDrunk.new()
		else: 
			self.next_cutscene = PaulCutscene1.new()
		super.advance_cutscene()
