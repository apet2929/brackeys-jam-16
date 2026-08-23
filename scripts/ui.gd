class_name UI
extends Control
signal dialogue_start(speaker_lines: SpeakerLines)
signal dialogue_end
# signal dialogue_next_line

var current_dialogue: SpeakerLines = null
var current_dialogue_display: DialogueDisplay = null
var current_line = 0

func start_dialogue(dialogue_lines: SpeakerLines):
	set_dialogue(dialogue_lines)
	self.dialogue_start.emit(dialogue_lines)
	
	
func set_dialogue(dialogue_lines: SpeakerLines):
	current_line = 0
	var display_inst = dialogue_lines.dialogue_display_scene.instantiate()
	self.add_child(display_inst)
	current_dialogue_display = display_inst
	current_dialogue = dialogue_lines
	update_dialogue_ui()

func advance_dialogue():
	if current_dialogue == null:
		return
	current_line += 1
	if current_line >= len(current_dialogue.lines):
		on_speaker_lines_end()
	else:
		update_dialogue_ui()
		
func on_speaker_lines_end():
	self.remove_child(current_dialogue_display)
	if current_dialogue.response == null:
		dialogue_end.emit()
	elif current_dialogue.response is SpeakerLines:
		set_dialogue(current_dialogue.response)
	elif current_dialogue.response is Array:
		set_dialogue(current_dialogue.response[0]) # TODO: let player choose response
	

func update_dialogue_ui():
	current_dialogue_display.set_line(current_dialogue.lines[current_line], current_dialogue.speaker)

func _input(event: InputEvent) -> void:
	# LMB released:
	if event is InputEventMouseButton and !event.pressed \
		and event.button_index == MOUSE_BUTTON_LEFT: 
			advance_dialogue()


	
