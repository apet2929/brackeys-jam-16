extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MASS = 80
const PUSH_FORCE = 5
var currently_held = null
var currently_held_layer = 0

func _physics_process(delta: float) -> void:
	if currently_held:
		currently_held.gravity_scale = 0
		currently_held.global_position = currently_held.global_position.lerp(%hand.global_position, delta * 50.0)
		currently_held.global_rotation = Vector3(0, %hand.global_rotation.y, 0)
		if Input.is_action_just_released("interact"):
			currently_held.gravity_scale = 1
			currently_held.collision_layer = currently_held_layer
			currently_held.apply_central_impulse((%head.global_basis.z) * -30)
			currently_held = null
	
	%interact_text.hide()
	if %interact_ray.is_colliding():
		var target = %interact_ray.get_collider()
		if target && (target.has_method("interact") || target.is_in_group("pickupable")):
				%interact_text.show()
				if Input.is_action_just_pressed("interact"):
					if target.has_method("interact"):
						target.interact()
					if target.is_in_group("pickupable"):
						currently_held = target
						currently_held_layer = target.collision_layer
						target.collision_layer = 0
				
				
	if not is_on_floor():
		velocity += get_gravity()*delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	_push_away_rigid_bodies()
	move_and_slide()

func _push_away_rigid_bodies():
	for i in get_slide_collision_count():
		var obj := get_slide_collision(i)
		var col := obj.get_collider()
		if col is RigidBody3D:
			var push_dir = -obj.get_normal()
			var velocity_diff_in_push_dir = self.velocity.dot(push_dir) - col.linear_velocity.dot(push_dir)
			velocity_diff_in_push_dir = max(0, velocity_diff_in_push_dir)
			var mass_ratio = min(1, MASS / col.mass)
			push_dir.y = 0
			var push_force = mass_ratio * PUSH_FORCE
			col.apply_impulse(push_dir * velocity_diff_in_push_dir * push_force, obj.get_position() - col.global_position)
			print("Collider: %s, push_dir: %s" % [col, push_dir])
