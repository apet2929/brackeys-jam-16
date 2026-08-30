class_name Main
extends Node3D

var complete_description = """[b][u]Description:[/u][/b]
Compound 87-C is an odorless, pale-yellow dust with particle size averaging 0.2 microns. The compound is known to cause numerous physiological, neurological, and psychological effects when ingested. Animal studies suggest that approximately ▮ grams would be fatal to the average adult human.

Compound 87-C is able to form an invisible aerosol extremely easily, even with minor agitation and low humidity.

[b][u]Chemical analysis:[/u][/b]
An initial spectroscopy study found the substance to be at least partially composed of a Helium-Sulfer excimer. It is unknown how this highly volatile substance remains in a stable solid form at room temperature.

Further analysis of the chemical structure is on hold following the incident at ▮▮▮▮▮▮▮▮ lab in North Carolina. (Incident report has been reclassified and is no longer contained in this dossier.)

[b][u]Handling precautions:[/u][/b]
Compound 87-C should be contained within a non-reactive ampule at all times. If a sample of the compound is released, either accidentally or intentionally, all persons within a 30-meter radius should immediately cover their mouth, hold their breath, and exit the vicinity while gently exhaling through their nose.

Ordinary dust/gas masks should not be assumed to be adequate protection. Better forms of protection are currently being developed for planned testing, transportation, and deployment."""

var complete_effects = """[b][u]Effects:[/u][/b]
Within 15 minutes of direct contact, ingestion, or inhalation of compound 87-C, subjects report a brief period of lightheadedness followed immediately by a drop in resting heart-rate. The initial physiological effects are noticeable as a moderate drop in stress. Subjects prone to anxious or paranoid behaviors appear joyful in low-stimulation environments, and disinterested in environments with negative stimulus. Within 1 hour of exposure, subjects enter a sustained period of euphoria.
The outward effects of the euphoria differ case-by-case, but nearly all subjects demonstrate an attitude of amusement at otherwise troubling information. In one instance, a subject was told that a nuclear strike was expected to impact their hometown. The subject stared at the wall for a few moments before beginning to chuckle to themself. The laughter continued for approximately 45 minutes, escalating and subsiding at random intervals.

Within 1.5 hours of exposure, physiological symptoms become noticeable. In all cases, the victim’s skin becomes pale across the entire body. Medical examination shows no evidence of anemia accompanying this skin discoloration. In about 75% of cases, the paleness is accompanied by increased redness near the nose and cheekbones.

Within 2 hours of exposure, 100% of victims experience sudden ▮▮▮▮▮▮▮▮▮▮ ▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮ This is usually followed by a momentary loss of consciousness. Acts of physical violence in the ensuing alertness are rare, but not unreported. In cases where subjects do become violent, supervisors report indications of heightened dexterity, balance, and acrobatic ability.

Unless certain measures are taken (see protocol 87-D), all subjects will eventually become preoccupied by their own amusement, to the extent they pay no attention to any person attempting to communicate with them or touch them in any way. Subjects appear to be incapable of experiencing pain, and will continue to engage in behaviors such as dance, juggling, balancing on furniture, or telling jokes to themselves, even if they are suffering from profuse bleeding, broken bones, or missing limbs. While subjects do not appear to be immune to physical ailment, they appear to have no need to consume food or water for upwards of 3 months.
"""
var complete_origin = """[b][u]Source[/u][/b]
There is currently no known method of synthesizing compound 87-C. All known samples were obtained from site 87-A. Site 87-A is a remote location near ▮▮▮▮▮▮▮▮▮ New Mexico containing the wreckage of ▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮
▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮.

[b][u]Ongoing incident report[/u][/b]
On August 23, 1953, a copy of indecent report 87-C-NC1 was reported missing from a secure compartmentalized information facility in DC. Several other documents related to 87-C have since been reported missing from various nearby facilities. Around the same time, a suspicious vehicle was noticed leaving the site. The plate on the vehicle was registered to a “Dr Philip Blanc”, a name not found in any other government database.  The vehicle was later spotted in the parking lot of the ▮▮▮▮▮▮▮▮▮ ▮▮▮▮▮▮▮▮▮ hotel, during an ongoing campaign banquet hosted by Senator Perry Terrell. An investigation unit was dispatched to recover the lost documents and prevent further unauthorized disclosure.
"""


# It's common to have 1 root scene that contains the current level
# and anything that should be persisted between levels
# the Main instance can be found via Globals.main
signal current_time_updated(new_current_time)
var current_time = 0.0
const MAX_TIME = 100
var game_over = false
var dossier_out = false
var dossier_page = 1

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

func flip_dossier() -> void:
	if dossier_page == 1:
		%Dossier1.visible = false
		%Dossier2.visible = true
		%Dossier3.visible = false
		dossier_page = 2
	elif dossier_page == 2:
		%Dossier1.visible = false
		%Dossier2.visible = false
		%Dossier3.visible = true
		dossier_page = 3
	elif dossier_page == 3:
		%Dossier1.visible = true
		%Dossier2.visible = false
		%Dossier3.visible = false
		dossier_page = 1
	%DossierIndex.text = str(dossier_page)
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if game_over:
			get_tree().quit()
		elif dossier_out:
			flip_dossier()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if !first_input_captured:
		first_input_captured = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event.is_action_released("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_released("tab"):
		if dossier_out:
			dossier_out = false
			%Player.unhide_ui()
			%DossierBG.visible = false
			%Dossier1.visible = false
			%Dossier2.visible = false
			%Dossier3.visible = false
			%DossierIndex.visible = false
		else:
			dossier_out = true
			%Player.hide_ui()
			%DossierBG.visible = true
			%Dossier1.visible = true
			%DossierIndex.visible = true
		

# Update the UI to un-redact dossier info based on our 3 "knows" bools
func update_dossier(knows_origin, knows_happy_effects, knows_aliens):
	if knows_aliens: 
		%Dossier1.text = complete_description
	if knows_happy_effects:
		%Dossier2.text = complete_effects
	if knows_origin:
		%Dossier3.text = complete_origin

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
