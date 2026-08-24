class_name DialogueDisplay
extends Control


# To adjust styles for UI, go to res://assets/dialogue_theme.tres
# styles for SpeakerName and Lines => RichTextLabel
# styles for SpeakerName => NameDisplay variant
# styles for Lines => LineDisplay variant
@onready var responses_container: ResponsesContainer = %Responses

func set_line(line: String, speaker: String):
	%Lines.text = line
	%SpeakerName.text = speaker

func show_responses(responses: Array[SpeakerLines.Response]):
	responses_container.set_responses(responses)
	
