extends Node

func _ready():
	set_fixed_process(true)
	set_process(true)

func _process(delta):
	pass

func _fixed_process(delta):
	get_node("Tipito").update(delta)