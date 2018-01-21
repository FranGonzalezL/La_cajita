extends Node

func _ready():
	set_fixed_process(true)
	set_process(true)

func _process(delta):
	if (Input.is_action_pressed("ui_accept")):
		var cajita = get_node("Cajita")
#		cajita.apply_impulse(Vector2(0, 0), Vector2(30, 0))
#		cajita.add_force(Vector2(0,0), Vector2(30, 0))
		cajita.set_applied_force(Vector2(100, 0))
	if (Input.is_action_pressed("ui_down")):
		var cajita = get_node("Cajita")
#		cajita.apply_impulse(Vector2(0, 0), Vector2(30, 0))
#		cajita.add_force(Vector2(0,0), Vector2(30, 0))
		cajita.set_applied_force(Vector2(0, 0))
		
func _fixed_process(delta):
	get_node("Tipito").update(delta)