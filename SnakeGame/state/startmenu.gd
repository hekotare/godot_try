extends State


func _process(_delta:float) -> void:
	if Input.is_action_just_pressed("ok"):
		fsm.translation_to("Playing")
