class_name SpeakerLines

var dialogue_display_scene = preload("res://scenes/dialogue_display.tscn")
var speaker: String
var lines: Array[String]
var response # (SpeakerLines or Array[SpeakerLines])

func _init(speaker: String, lines: Array[String], dialogue_scene:PackedScene=null):
	self.lines = lines
	self.speaker = speaker
	if dialogue_scene != null:
		self.dialogue_display_scene = dialogue_scene
		
func display():
	Globals.ui.start_dialogue(self)

func add_response(r: SpeakerLines):
	if response == null:
		response = r
	elif response is SpeakerLines:
		response = [response, r]
	elif response is Array:
		response.append(r)
	return r



# func init_portrait():
# 	if portrait_scene != null:
# 		var inst = portrait_scene.instantiate()
# 		inst.build(portrait_args)
# 		return inst
# 	else:
# 		var basic_dialogue_portrait_scene = load("res://scenes/dialogue/basic_dialogue_portrait.tscn")
# 		var inst = basic_dialogue_portrait_scene.instantiate()
# 		inst.build([portrait_texture])
# 		return inst
	
