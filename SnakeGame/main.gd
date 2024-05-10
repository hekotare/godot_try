extends Node2D

var world


func _ready():
	world = World.new()
	add_child(world)


func _on_fsm_translated(state_name:String) -> void:
	print_debug("fsm translated ->" + state_name)
