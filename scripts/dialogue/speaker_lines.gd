class_name SpeakerLines

var dialogue_display_scene = preload("res://scenes/dialogue_display.tscn")
var speaker: String
var lines: Array[String]
var next_line: SpeakerLines = null # optional, next SpeakerLines to show after this one
var response_options: Array[Response] = [] # optional, selectable responses for the player

class Response:
	var response_text: String
	var next_lines: SpeakerLines # SpeakerLines to display when this response is selected
	func _init(text: String, next_lines: SpeakerLines):
		self.response_text = text
		self.next_lines = next_lines
	

func _init(speaker: String, lines: Array[String], dialogue_scene:PackedScene=null):
	self.lines = lines
	self.speaker = speaker
	if dialogue_scene != null:
		self.dialogue_display_scene = dialogue_scene
		
func display():
	Globals.ui.start_dialogue(self)

func has_response_options():
	return len(self.response_options) > 0


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
	
