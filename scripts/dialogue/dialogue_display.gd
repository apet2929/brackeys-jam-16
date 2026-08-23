class_name DialogueDisplay
extends Control


# To adjust styles for UI, go to res://assets/dialogue_theme.tres
# styles for SpeakerName and Lines => RichTextLabel
# styles for SpeakerName => NameDisplay variant
# styles for Lines => LineDisplay variant

signal response_selected(response: SpeakerLines.Response)

func _ready() -> void:
	%Responses.response_selected.connect((func (arg):
		response_selected.emit(arg))
	)

func set_line(line: String, speaker: String):
	%Lines.text = line
	%SpeakerName.text = speaker

func show_responses(responses: Array[SpeakerLines.Response]):
	%Responses.set_responses(responses)
	
