class_name Main
extends Node3D

# It's common to have 1 root scene that contains the current level
# and anything that should be persisted between levels
# the Main instance can be found via Globals.main
signal current_time_updated(new_current_time)
var current_time = 0.0
const MAX_TIME = 100
var game_over = false

# In web builds, we can't capture mouse input until atleast 1 input event is registered
var first_input_captured = false 

@onready var music_track: AudioStreamPlayer = $music_track
@onready var ambience: AudioStreamPlayer = $ambience

func _ready() -> void:

	Globals.initialize()
	$UI.globals_ready()
	$UI.dialogue_end.connect(increment_time)
	current_time_updated.emit(current_time)
	%fade_transition/AnimationPlayer.play("fade_out")
	
	# fade the music/ambience in
	music_track.volume_db = -20.0
	ambience.volume_db = -20.0
	music_track.play()
	var music_fade := create_tween()
	music_fade.tween_property(music_track, "volume_db", 0.0, 1.0)
	var ambience_fade := create_tween()
	ambience_fade.tween_property(ambience, "volume_db", -1.793, 1.0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if game_over:
			get_tree().quit()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if !first_input_captured:
		first_input_captured = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event.is_action_released("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("tab"):
		%Player.hide_ui()
		%DossierBG.visible = true
		%Dossier.visible = true
	if event.is_action_released("tab"):
		%Player.unhide_ui()
		%DossierBG.visible = false
		%Dossier.visible = false
		

# Update the UI to un-redact dossier info based on our 3 "knows" bools
func update_dossier(knows_origin, knows_happy_effects, knows_aliens):
	var dossier = "Current progress: \n"
	if knows_origin:
		dossier += "1. Originated in a lab in North Carolina\n"
	else:
		dossier += "1. UNKNOWN\n"
	if knows_happy_effects:
		dossier += "2. The substance causes subjects to become overly happy and eventually die\n"
	else:
		dossier += "2. UNKNOWN\n"
	if knows_aliens:
		dossier += "3. Substance came from an alien landing\n"
	else:
		dossier += "3. UNKNOWN\n"
	%Dossier.text = dossier
func accuse(person: String) -> void:
	%Player.hide_ui()
	%EndScreen.visible = true
	%EndTitle.visible = true
	%EndText.visible = true
	game_over = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if person == "Paul":
		%EndTitle.text = "YOU WIN!"
		%EndText.text = "Paul was the leaker. He frequently visited his family near the site in North Carolina, had a security clearance for access, and offhand mentioned excessive laughing."
	else:
		%EndTitle.text = "YOU LOSE!"
		%EndText.text = "Sorry, "+person+" was not the leaker."

func increment_time():
	current_time += 10
	current_time_updated.emit(current_time)
	print("Current time is now: %f" % current_time)
