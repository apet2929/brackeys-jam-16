class_name DialogueResponseOptionDisplay
extends PanelContainer

var response: SpeakerLines.Response = null

func set_response(response: SpeakerLines.Response):
	self.response = response
	$Text.text = response.response_text

func set_selected(selected: bool):
	if selected:
		self.theme_type_variation = "ResponseSelected"
		$Text.theme_type_variation = "ResponseTextSelected"
	else:
		self.theme_type_variation = "Response"
		$Text.theme_type_variation = "ResponseText"
