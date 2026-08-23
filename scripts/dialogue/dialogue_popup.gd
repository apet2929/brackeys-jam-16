extends Panel

var current_lines: SpeakerLines = null
var current_line = 0

signal dialogue_finished
signal select_response(options: Array[SpeakerLines])


func _init() -> void:
	self.cutscene = ExampleCutscene.new()

# func reset():
# 	self.current_line = 0
# 	self.current_outer_line = 0

# func start_cutscene():
# 	self.visible = true
# 	print("Starting cutscene!")
# 	update_portrait()
# 	next_line()

# func finish_cutscene():
# 	self.visible = false
# 	self.finished.emit()
# 	self.reset()

# func next_line():
# 	if cutscene == null or len(cutscene.lines) == 0:
# 		return
		
# 	if current_line >= len(cutscene.lines[current_outer_line].lines):
# 		current_outer_line += 1
# 		current_line = 0
		
# 		# print("Moving to next cutscene chunk!: %d" % current_outer_line)
# 		if current_outer_line >= len(cutscene.lines):
# 			finish_cutscene()
# 			return
# 		else:
# 			update_portrait()
	
# 	show_current_line()
# 	current_line += 1

# func update_portrait():
# 	while %PortraitContainer.get_children().size() > 0:
# 		%PortraitContainer.remove_child(%PortraitContainer.get_child(0))
# 	%PortraitContainer.add_child(cutscene.lines[current_outer_line].init_portrait())

# func show_current_line():
# 	var outer_line = cutscene.lines[current_outer_line]
# 	# rev a2eb138b5cfdb61966eb1470aeee1e8f0823e5d2 has some code for user response choices 
# 	# I scrapped it b.c. it was a WIP and I'm not sure what the requirements are
# 	# - Andrew
# 	$ViewForLines.visible = true
# 	%CharacterName.text = outer_line.speaker
# 	var line = cutscene.lines[current_outer_line].lines[current_line]
# 	%Dialogue.text = line
	

# func _ready() -> void:
# 	reset()
# 	$AdvanceDialogue.pressed.connect(next_line)
# 	start_cutscene()
