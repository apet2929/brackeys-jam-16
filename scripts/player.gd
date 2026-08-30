extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MASS = 80
const PUSH_FORCE = 5

var currently_held: PhysicsBody3D = null
var currently_held_layer = 0
var crouched = false

var inventory_held_item = null 
var inventory_held_item_idx = -1
var inventory: Array[PackedScene] = []

@onready var notepad = $Notepad
var notepad_theme = Theme.new()

var left_foot = true
var last_footstep = 0.0
var in_dialogue = false

func _ready() -> void:
	notepad.visible = false
	notepad.tab_input_mode = false
	notepad.theme = load("res://assets/notepad.tres")
	#add_to_inventory(load("res://scenes/gun.tscn"))
	#add_to_inventory(load("res://scenes/gun2.tscn"))
	%UI.dialogue_start.connect(
		(func (_arg):
			self.in_dialogue = true
			self.hide_ui()
			%head.in_dialogue = true))
	
	%UI.dialogue_end.connect(
		(func ():
			self.in_dialogue = false
			self.unhide_ui()
			%head.in_dialogue = false))

func _physics_process(delta: float) -> void:
	if notepad.visible:
		return
	if not is_on_floor():
		velocity += get_gravity()*delta
	if in_dialogue:
		velocity.x = 0
		velocity.z = 0
	else:
		if currently_held:
			currently_held.gravity_scale = 0
			currently_held.global_position = currently_held.global_position.lerp(%hand.global_position, delta * 50.0)
			currently_held.global_rotation = Vector3(0, %hand.global_rotation.y, 0)
			if Input.is_action_just_released("interact"):
				toss_held_item()
		
		%interact_text.hide()
		if %interact_ray.is_colliding():
			var target = %interact_ray.get_collider()
			if target && target.is_in_group("interactable") && target.interactable():
					%interact_text.show()
					if Input.is_action_just_pressed("interact"):
						if target.is_in_group("interactable"):
							target.interact()
						if target.is_in_group("pickupable"):
							pickup_item(target)
					
		
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		var input_dir := Input.get_vector("left", "right", "forward", "back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			
			last_footstep += velocity.length() * delta
			if last_footstep >= 100.0:
				last_footstep = 0.0
				make_footprint()
		else: 
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
		_push_away_rigid_bodies()
	move_and_slide()
	
func toggle_notepad():
	if not notepad.visible:
		notepad.visible = true
		notepad.grab_focus.call_deferred()
		print("notepad opened!")
	else:
		notepad.visible = false
		print("notepad closed!")

func pickup_item(target):
	if inventory_held_item != null:
		unequip_item_from_inventory()
		inventory_held_item_idx = -1
	currently_held = target
	currently_held_layer = target.collision_layer
	target.collision_layer = 0
		
func toss_held_item():
	if currently_held is PhysicsBody3D:
		currently_held.gravity_scale = 1
		currently_held.collision_layer = currently_held_layer
		currently_held.apply_central_impulse((%head.global_basis.z) * -30)
	currently_held = null

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

func make_footprint():
	var foot_marker: Marker3D #current foot to print
	foot_marker = $LeftFoot if left_foot else $RightFoot
	left_foot = !left_foot
	
	var foot_location = Transform3D()
	foot_location.origin.y = 1
	
	$Footprints.emit_particle(
		transform,
		Vector3.ZERO,
		Color.WHITE,
		Color.WHITE,
		0
	)

func _process(delta: float) -> void: 		
	if Input.is_action_just_pressed("open_notepad"):
		toggle_notepad()
		return
		
	if Input.is_action_pressed("crouch"):
		_crouch()
	else:
		_uncrouch()
		
	if Input.is_action_just_pressed("use"):
		if currently_held and currently_held.has_method("use"):
			currently_held.use()
		
func increment_inventory_held_item(dir):
	if inventory_held_item == null:
		inventory_held_item_idx = 0
	else:
		unequip_item_from_inventory()
		inventory_held_item_idx = (inventory_held_item_idx + dir) % len(inventory)
	
	equip_item_from_inventory(inventory_held_item_idx)

func add_to_inventory(item: PackedScene):
	if !inventory.has(item):
		inventory.append(item)

func equip_item_from_inventory(index: int):
	inventory_held_item = inventory[index].instantiate()
	print("Equipping %s" % inventory_held_item)
	%hand.add_child(inventory_held_item)
	inventory_held_item.global_position = %hand.global_position
	inventory_held_item.global_rotation = Vector3(0, %hand.global_rotation.y, 0)

func unequip_item_from_inventory():
	%hand.remove_child(inventory_held_item)
	inventory_held_item.queue_free()
	inventory_held_item = null

func _crouch():
	if not crouched:
		#Use a tween to make it smoother
		var t := create_tween()
		#Tween y axis of the collision shape to 0.5 in 0.1 second
		print("crouch")
		#t.tween_property($CollisionShape3D, "scale:y", 0.5, 0.1)
		t.tween_property($head, "position:y", 1, 0.1)
		crouched = true
	
func _uncrouch():
	if crouched:
		var t := create_tween()
		print("uncrouch")
		#t.tween_property($CollisionShape3D, "scale:y", 1, 0.1)
		t.tween_property($head, "position:y", 1.6, 0.1)
		crouched = false
	
func hide_ui():
	%CanvasLayer.visible = false
	
func unhide_ui():
	%CanvasLayer.visible = true
