extends Control

@onready var fade = $fade_transition
@onready var fade_timer = $fade_transition/Timer
@onready var fade_animation = $fade_transition/AnimationPlayer
@onready var music_track: AudioStreamPlayer = $music_track


func _on_start_pressed() -> void:
	# fade the music out
	var music_fade := create_tween()
	music_fade.tween_property(music_track, "volume_db", -30.0, 1.0)

	fade.show()
	fade_timer.start()
	fade_animation.play("fade_in")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
