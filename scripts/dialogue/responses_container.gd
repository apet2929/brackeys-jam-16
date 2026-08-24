class_name ResponsesContainer
extends VBoxContainer

@onready var response_option_scene = preload("res://scenes/dialogue_response_option.tscn")

var selected_response_idx = 0
var responses: Array[DialogueResponseOptionDisplay] = []

func set_responses(responses: Array[SpeakerLines.Response]):
	reset()
	for response in responses:
		self.add_response(response)
	set_selected(0)

func add_response(response: SpeakerLines.Response):
	var response_display: DialogueResponseOptionDisplay = response_option_scene.instantiate()
	response_display.set_response(response)
	self.responses.append(response_display)
	self.add_child(response_display)
	
func set_selected(idx):
	assert(idx == 0 or idx < len(responses))
	selected_response_idx = idx
	if responses.is_empty():
		return
	
	var selected_response = responses[idx]
	for r in responses:
		r.set_selected(false)
	selected_response.set_selected(true)
	
func reset():
	for r in self.get_children():
		self.remove_child(r)
	selected_response_idx = 0
	responses = []

func _input(event: InputEvent) -> void:
	if len(responses) <= 0:
		return
	
	if Input.is_action_just_released("ui_accept"):
		Globals.ui.on_response_selected(responses[selected_response_idx].response)
		self.reset()
	if Input.is_action_just_released("ui_up"):
		set_selected((selected_response_idx - 1) % len(responses))
	if Input.is_action_just_released("ui_down"):
		set_selected((selected_response_idx + 1) % len(responses))
		
		
