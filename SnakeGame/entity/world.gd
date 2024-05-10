class_name World extends Node2D


signal get_food() # プレイヤーがフードを獲得！
signal player_out_of_world() # プレイヤーがワールドの外に出た！

var player
var food


func _process(_delta):
	var t:Transform2D = Transform2D()
	t = t.scaled(Vector2(Global.CELL_SIZE, Global.CELL_SIZE))
	transform = t


func _draw() -> void:
	_draw_grid(Global.CELL_SIZE, Global.CELL_SIZE)


func reset(pos:Vector2):

	# remove entity
	if player != null:
		remove_child(player)
	if food != null:
		remove_child(food)
	
	# create entity
	player = Character.new()
	add_child(player)
	
	player.initialize(pos)
	
	_generate_food()


# プレイヤーを移動
func next():
	player.move()
	
	if _check_death():
		player_out_of_world.emit()
		return
	
	if _check_food():
		remove_child(food)
		player.eat_food(food)
		
		_generate_food()
		
		get_food.emit()


func _generate_food():
	var x:int = randi_range(0, int(Global.CELLS_X) - 1)
	var y:int = randi_range(0, int(Global.CELLS_Y) - 1)
	
	food = Tile.new()
	add_child(food)
	food.position = Vector2(x, y)
	
	print_debug("generate food:" + str(food.position))


func _check_death():
	# プレイヤー自身の衝突
	if player.check_overlap_body():
		return true
	
	# ワールドの外側に出た
	return \
		player.position.x < 0 or Global.CELLS_X <= player.position.x or \
		player.position.y < 0 or Global.CELLS_Y <= player.position.y


func _check_food():
	return player.position == food.position


func _draw_grid(cell_w, cell_h):

	var extent = DisplayServer.window_get_size()
	var cells_x = ceil(float(extent.x) / cell_w)
	var cells_y = ceil(float(extent.y) / cell_h)
	
	for i in range(cells_x):
		draw_line(Vector2(i, 0), Vector2(i, cells_y), Color(0, 0, 0), 1.0/Global.CELL_SIZE, true)
	
	for i in range(cells_y):
		draw_line(Vector2(0, i), Vector2(cells_x, i), Color(0, 0, 0), 1.0/Global.CELL_SIZE, true)
