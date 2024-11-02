@tool
class_name AABB2D extends Node2D


@export var grid_size:int = 0:
	set = set_gridSize,
	get = get_gridSize

@export var left:int = 0:
	set = set_left,
	get = get_left

@export var top:int = 0:
	set = set_top,
	get = get_top

@export var right:int = 100:
	set = set_right,
	get = get_right

@export var bottom:int = 80:
	set = set_bottom,
	get = get_bottom

@export var rect:Rect2:
	set = set_rect,
	get = get_rect


func set_gridSize(v):
	grid_size = v

func get_gridSize() ->int:
	return grid_size

func set_left(v):
	left = v
	queue_redraw()

func get_left() -> int:
	return left

func set_top(v):
	top = v
	queue_redraw()

func get_top() -> int:
	return top

func set_right(v):
	right = v
	queue_redraw()

func get_right() -> int:
	return right

func set_bottom(v):
	bottom = v
	queue_redraw()

func get_bottom() -> int:
	return bottom


func set_rect(r:Rect2) -> void:
	left = r.position.x
	top = r.position.y
	right = r.end.x
	bottom = r.end.y


func get_rect() -> Rect2:
	var r := Rect2()
	r.position = Vector2(left, top)
	r.end = Vector2(right, bottom)
	return r


func _draw():
	draw_rect(rect, Color.AQUA, false, 4.0)
