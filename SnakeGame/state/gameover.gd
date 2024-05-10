extends State


func _ready():

	var anim:AnimationPlayer = get_node("AnimationPlayer")
	anim.play("display")
	anim.seek(0, true)
	
	await anim.animation_finished
	
	fsm.translation_to("StartMenu")
