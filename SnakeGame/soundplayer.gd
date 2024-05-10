extends AudioStreamPlayer2D

var bosu13 = preload("res://sounds/bosu13.ogg")
var cursor08 = preload("res://sounds/cursor08.ogg")


func _ready():
	await owner.ready
	
	owner.world.get_food.connect(get_food)
	owner.world.player_out_of_world.connect(player_out_of_world)


func sound_play(sound_res):
	stop()
	set_stream(sound_res)
	play()


func player_out_of_world():
	sound_play(bosu13)


func get_food():
	sound_play(cursor08)
