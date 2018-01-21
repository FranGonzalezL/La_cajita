extends RigidBody2D

const GRAVITY = 60
const WALK_SPEED = 500
const JUMP_SPEED = 15
const MAX_SPEED = 9

var velocity = Vector2(0, 0)
var step = 0
var state = "airborne"

var up
var left
var right

func _integrate_forces(state):
	velocity = state.get_linear_velocity()
	step = state.get_step()
	
	print(step)

	# Update input flags
	update_input()
		
	# Update velocity via input
	if (left && !right):
		velocity.x -= WALK_SPEED * step
	elif (right && !left):
		velocity.x += WALK_SPEED * step
	
	state.set_linear_velocity(velocity)
	
	# Update velocity via input
	#if (state == "grounded"):
	#	grounded_state(delta)
	#elif (state == "airborne"):
	#	airborne_state(delta)
	#else:
	#	print("State not found")
	#	get_tree().quit()
	
	#if (is_colliding()):
	#	state = "grounded"

func update_input():
	up = Input.is_action_pressed("ui_up")
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
