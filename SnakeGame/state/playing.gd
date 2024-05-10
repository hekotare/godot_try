extends State


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	$MovingTimer.start(0.2)
	
	fsm.owner.world.reset(Vector2(2, 2))
	
	fsm.owner.world.player_out_of_world.connect(_on_player_out_of_world)


func exit() -> void:
	fsm.owner.world.player_out_of_world.disconnect(_on_player_out_of_world)


func _on_moving_timer_timeout():
	fsm.owner.world.next()


func _on_player_out_of_world():
	fsm.translation_to("GameOver")
