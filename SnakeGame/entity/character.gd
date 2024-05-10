class_name Character
extends Node2D

var dir:Vector2 = Vector2.RIGHT
var input_dir:Vector2
var foot_list:Array = [] # 足跡リスト


func initialize(pos):

	position = pos
	foot_list.append(position)
	
	var t:Tile = Tile.new()
	eat_food(t)
	
	t.head = true


func _ready():
	var t:Transform2D = Transform2D()
	t.translated(Vector2(50, 50))
	t.scaled(Vector2(1.0/Global.CELL_SIZE, 1.0/Global.CELL_SIZE))
	
	transform = t


func _process(_delta):

	# キャラの向きを変更
	if Input.is_action_pressed("move_left"):
		input_dir = Vector2.LEFT
	elif Input.is_action_pressed("move_right"):
		input_dir = Vector2.RIGHT
	elif Input.is_action_pressed("move_up"):
		input_dir = Vector2.UP
	elif Input.is_action_pressed("move_down"):
		input_dir = Vector2.DOWN


func try_change_dir(new_dir:Vector2):
	if dir == -new_dir: return # 反転は禁止
	
	dir = new_dir


func move():

	try_change_dir(input_dir)
	
	# move
	position += dir
	foot_list.push_front(position)
	
	for p in Global.zip(foot_list, get_children()):
		var pos:Vector2 = p[0]
		var tile:Tile = p[1]
		
		tile.position = pos - position
	
	# 不要な足跡を消す（自分の体＋新しい体1つ分を残して消す）
	var n:int = foot_list.size() - (get_children().size() + 1)
	for i in n:
		foot_list.pop_back()


func check_overlap_body():
	# ヘッド以外のタイルが、
	# キャラクタの座標と重なっている（小ノードなので0, 0)
	for c in get_children().slice(1):
		if c.position == Vector2(0, 0):
			return true


func eat_food(tile):
	add_child(tile)
	
	tile.position = foot_list[foot_list.size() - 1] - position
