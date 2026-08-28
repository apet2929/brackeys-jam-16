extends Control

@onready var fade = $fade_transition
@onready var fade_timer = $fade_transition/Timer
@onready var fade_animation = $fade_transition/AnimationPlayer

func _on_start_pressed() -> void:
	fade.show()
	fade_timer.start()
	fade_animation.play("fade_in")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
