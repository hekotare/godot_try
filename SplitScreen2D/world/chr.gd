extends CharacterBody2D

var speed:float = 400
var jump_speed:float = -400
var gravity:float = 300

@export var player_id:int = 1

enum Dir { LEFT, RIGHT }
@export var dir:Dir = Dir.RIGHT

@onready var anim_player:AnimationPlayer = $AnimationPlayer
@onready var pivot:Node2D = $Pivot

func _physics_process(_delta):

	if not is_on_floor():
		velocity.y += _delta * gravity
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump_player" + str(player_id)):# and is_on_floor():
		velocity.y = jump_speed
	
	# Get the input direction.
	var direction:float = Input.get_axis("left_player" + str(player_id), "right_player" + str(player_id))
	velocity.x = direction * speed
	
	if direction != 0.0:
		anim_player.play("run")
	else:
		anim_player.play("idle")
	
	if direction < 0.0:		dir = Dir.LEFT
	elif 0.0 < direction:	dir = Dir.RIGHT
	
	if dir == Dir.LEFT: 	pivot.scale.x = -1.0
	elif dir == Dir.RIGHT:  pivot.scale.x =  1.0
	
	move_and_slide()
