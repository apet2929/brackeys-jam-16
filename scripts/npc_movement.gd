extends CharacterBody3D

@export var acceleration = 10
@export var speed = 2
@export var nav_group_name: String

@onready var nav_agent = $NavigationAgent3D
@onready var player = %Player
@onready var skin = $Sprite3D

var colliding_player = null
# State list: 
# 0 = idle
# 1 = moving
# 2 = chatting

var state = 0

var positions: Array
var current_position: Marker3D

func _ready():
	skin.set_move_speed(speed)
	nav_agent.avoidance_enabled = true
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	
	_get_positions()
	_get_next_position()
	
	# idle for 3 seconds before starting to move
	await get_tree().create_timer(3.0).timeout
	state = 1

func _physics_process(delta: float) -> void:
	if state == 0:
		nav_agent.velocity = Vector3.ZERO
		skin.idle()
		
	elif state == 1:
		skin.move()
		if global_position.distance_to(current_position.position) < 2:
			_get_next_position()
		nav_agent.target_position = current_position.global_position
		
		var next_pos = nav_agent.get_next_path_position()
		var direction = next_pos - global_position
		direction = direction.normalized()
		var desired_velocity = velocity.lerp(direction * speed, acceleration * delta)
		nav_agent.velocity = desired_velocity
		
		next_pos.y = global_position.y
		if global_position.distance_to(next_pos) > 0.1:
			var target_transform = global_transform.looking_at(next_pos, Vector3.UP)
			global_transform.basis = global_transform.basis.slerp(target_transform.basis, 8.0 * delta)
		
		rotation.x = 0
		rotation.z = 0
		
		if colliding_player != null:
			nav_agent.velocity = Vector3.ZERO
			state = 2
			
	elif state == 2:
		skin.victory_sign()

func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()

func _get_positions():
	positions = get_tree().get_nodes_in_group(nav_group_name)
	positions.shuffle()

func _get_next_position():
	current_position = positions.pop_front()
	positions.push_back(current_position)
	state = 0
	
	var time_to_wait = randf_range(3.0, 10.0)
	await get_tree().create_timer(time_to_wait).timeout
	if state == 0: 
		state = 1

func interact() -> void:
	var cutscene = ExampleCutscene.new()
	self.state = 2
	cutscene.display()
	Globals.ui.dialogue_end.connect(on_cutscene_end)
	
func on_cutscene_end():
	self.state = 0
	
