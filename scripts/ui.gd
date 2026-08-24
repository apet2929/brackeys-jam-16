class_name UI
extends Control
signal dialogue_start(speaker_lines: SpeakerLines)
signal dialogue_end
signal dialogue_response_selected(response: SpeakerLines.Response)
# signal dialogue_next_line

var current_dialogue: SpeakerLines = null
var current_dialogue_display: DialogueDisplay = null
var current_line = 0
var selecting_response = false

func _ready() -> void:
	$Timer.max_value = Globals.main.MAX_TIME
	Globals.main.current_time_updated.connect(update_timer)

func update_timer(time):
	$Timer.value = Globals.main.MAX_TIME - time
	
func in_dialogue() -> bool:
	return current_dialogue != null

func start_dialogue(dialogue_lines: SpeakerLines):
	set_dialogue(dialogue_lines)
	self.dialogue_start.emit(dialogue_lines)

func on_response_selected(response: SpeakerLines.Response):
	selecting_response = false
	set_dialogue(response.next_lines)
	dialogue_response_selected.emit(response)

func set_dialogue(dialogue_lines: SpeakerLines):
	reset()
	current_dialogue = dialogue_lines
	#var display_inst = load("res://scenes/dialogue_display.tscn").instantiate() #dialogue_lines.dialogue_display_scene.instantiate()
	var display_inst = dialogue_lines.dialogue_display_scene.instantiate()
	current_dialogue_display = display_inst
	self.add_child(current_dialogue_display)
	update_dialogue_ui()

func reset():
	if current_dialogue_display != null:
		self.remove_child(current_dialogue_display)
		current_dialogue_display = null
	self.current_dialogue = null
	self.current_line = 0
	

func advance_dialogue():
	if current_dialogue == null:
		return
	current_line += 1
	if current_line >= len(current_dialogue.lines):
		on_speaker_lines_end()
	else:
		update_dialogue_ui()
		
func on_speaker_lines_end():
	if current_dialogue.has_response_options():
		current_dialogue_display.show_responses(current_dialogue.response_options)
		self.selecting_response = true
		return
	
	if current_dialogue.next_line != null:
		set_dialogue(current_dialogue.next_line)
	else:
		dialogue_end.emit()
		self.reset()


func update_dialogue_ui():
	current_dialogue_display.set_line(current_dialogue.lines[current_line], current_dialogue.speaker)

func _input(event: InputEvent) -> void:
	# LMB released:
	if event is InputEventMouseButton and !event.pressed \
		and event.button_index == MOUSE_BUTTON_LEFT: 
			advance_dialogue()
	
