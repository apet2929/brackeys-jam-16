class_name CutsceneController
extends Resource

var next_cutscene: Cutscene
var current_cutscene: Cutscene

func display_next():
	current_cutscene.display()
	
	await Globals.ui.dialogue_end

func advance_cutscene():
	# next_cutscene not modified so looping is simple
	current_cutscene = next_cutscene
