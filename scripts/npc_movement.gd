extends CharacterBody3D

@export var acceleration = 10
@export var speed = 2

@onready var nav_agent = $NavigationAgent3D
@onready var player = %Player
@onready var skin = $GobotSkin2

var done = false
var colliding_player = null

func _ready():
	skin.set_move_speed(speed)
	skin.idle()

func _process(delta: float) -> void:
	if !done:
		# aim at player for now
		nav_agent.target_position = player.global_position
				
		var direction = nav_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, acceleration * delta)
		
		look_at(nav_agent.target_position)
		rotation.x = 0
		rotation.z = 0
		skin.move()
		move_and_slide()
		
		if colliding_player != null:
			done = true
	else:
		skin.victory_sign()
