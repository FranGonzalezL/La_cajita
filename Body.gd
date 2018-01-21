extends KinematicBody2D

const GRAVITY = 60
const WALK_SPEED = 140
const JUMP_SPEED = 15
const MAX_SPEED = 9
const FRICTION = 100

var velocity = Vector2(0, 0)
var state = "airborne"

var up
var left
var right

func update(delta):
	# Update input flags
	update_input()
	
	# Update velocity via gravity
	velocity.y += GRAVITY * delta
	
	# Update velocity via input
	if (state == "grounded"):
		grounded_state(delta)
	elif (state == "airborne"):
		airborne_state(delta)
	else:
		print("State not found")
		get_tree().quit()
	
	# Move bitch
	var motion = velocity
	motion = move(motion)

	# Floor detection
	if (is_colliding()):
		state = "grounded"
	
	# Collision resolution
	if (is_colliding()):
		# Push rigid object
		var collider = get_collider()
		if (collider extends RigidBody2D):
			var impulse_direction = -get_collision_normal()
			var impulse_norm = motion.dot(impulse_direction)
			var relative_collision_pos = get_collision_pos() - collider.get_pos()
			collider.apply_impulse(relative_collision_pos,
			                       impulse_direction * impulse_norm)
		# Rellocate
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

func update_input():
	up = Input.is_action_pressed("ui_up")
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
	
func grounded_state(delta):
	if (up):
		velocity.y = -JUMP_SPEED
		state = "airborne"
	elif (left && !right):
		velocity.x -= WALK_SPEED * delta
	elif (right && !left):
		velocity.x += WALK_SPEED * delta
	else:
		var is_negative = velocity.x < 0
		var module = max(0, abs(velocity.x) - FRICTION * delta)
		if is_negative:
			velocity.x = -module
		else:
			velocity.x = module
	clamp_xvelocity()

func airborne_state(delta):
	if (left && !right):
		velocity.x -= WALK_SPEED * delta
	elif (right && !left):
		velocity.x += WALK_SPEED * delta
	clamp_xvelocity()

func clamp_xvelocity():
	if velocity.x > MAX_SPEED:
		velocity.x = MAX_SPEED
	elif velocity.x < - MAX_SPEED:
		velocity.x = -MAX_SPEED