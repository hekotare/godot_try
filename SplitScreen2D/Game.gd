extends Node

@onready var player1 = %World.get_node("Player1")
@onready var player2 = %World.get_node("Player2")
@onready var camera1 = %World.get_node("Camera")
@onready var camera2 = %Camera2
@onready var camera3 = %Camera3
@onready var view = %View
@onready var viewport1 = %SubViewport1
@onready var viewport2 = %SubViewport2
@onready var viewport3 = %SubViewport3

func _ready():
	viewport2.world_2d = viewport1.world_2d
	viewport3.world_2d = viewport1.world_2d
	
	viewport1.transparent_bg = true
	viewport2.transparent_bg = true
	viewport3.transparent_bg = true

func _physics_process(_delta):

	var to:Vector2 = player1.global_position - player2.global_position
	
	camera1.global_position = player1.global_position
	camera2.global_position = player2.global_position
	camera3.global_position = (player1.global_position + player2.global_position) * 0.5
	
	# 300以上離れたら画面分割
	if 300 <= to.length():
		var dist:float = clamp((to.length() - 300) / 1200, 0.0, 1.0)
		var camera_ofs:float = dist * (0.25 - 0.13) + 0.13 # 0.13 ～ 0.25
		
		#print("to_length:" + str(to.length()) + "camera_ofs:" + str(camera_ofs))
		
		camera1.global_position = player1.global_position - to.normalized() * 1200 * camera_ofs
		camera2.global_position = player2.global_position + to.normalized() * 1200 * camera_ofs
		
		view.material.set_shader_parameter("is_split", true)
		view.material.set_shader_parameter("to", to.normalized())
		view.material.set_shader_parameter("viewport1", viewport1.get_texture())
		view.material.set_shader_parameter("viewport2", viewport2.get_texture())
		view.material.set_shader_parameter("split_line_tickness", 1 + dist * 18)
		view.material.set_shader_parameter("split_line_color", Color.BLACK)
	else:
		view.material.set_shader_parameter("is_split", false)
		view.material.set_shader_parameter("viewport1", viewport3.get_texture())
	


	
	
