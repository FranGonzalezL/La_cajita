extends RigidBody2D

var applied_velocity = Vector2(0, 0)
var timer = 0

func _integrate_forces(state):
	print(get_linear_velocity())

#func moveIt(delta):
#	if (is_colliding()):
#		var collider = get_collider()
#		if (collider extends KinematicBody):
#			self.add_force(Vector2(0,0), Vector2(30, 0))