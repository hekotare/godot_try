@tool
extends EditorPlugin


enum DragBits {
	NONE = 0,
	LEFT = 0x01,
	TOP  = 0x02,
	RIGHT = 0x04,
	BOTTOM = 0x08
}


var inspector_plugin:EditorInspectorPlugin

var current_object:AABB2D
var drag_state:DragBits


func _enter_tree():
	add_custom_type("AABB2D", "Node2D", preload("res://addons/aabb2d/obj.gd"), preload("res://icon.svg"))
	
	inspector_plugin = preload("res://addons/aabb2d/inspector_plugin.gd").new(get_undo_redo())
	add_inspector_plugin(inspector_plugin)


func _exit_tree():
	remove_custom_type("AABB2D")
	remove_inspector_plugin(inspector_plugin)


func _handles(object):
	return object is AABB2D


func _edit(object):
	current_object = object as AABB2D


func _forward_canvas_draw_over_viewport(viewport_control):
	var bits := hitTest()
	
	var c:Control.CursorShape = Control.CURSOR_ARROW
	
	if bits in [DragBits.LEFT, DragBits.RIGHT]:
		c = Control.CURSOR_HSIZE
	elif bits in [DragBits.TOP, DragBits.BOTTOM]:
		c = Control.CURSOR_VSIZE
	elif bits in [DragBits.LEFT | DragBits.BOTTOM, DragBits.RIGHT | DragBits.TOP]:
		c = Control.CURSOR_BDIAGSIZE
	elif bits in [DragBits.RIGHT | DragBits.BOTTOM, DragBits.LEFT | DragBits.TOP]:
		c = Control.CURSOR_FDIAGSIZE
	
	viewport_control.mouse_default_cursor_shape = c


func hitTest() -> DragBits:
	var mouse_pos := current_object.get_local_mouse_position()
	var r := current_object.rect
	var bits:int
	const collision_size:int = 4
	
	if r.grow(collision_size).has_point(mouse_pos):
		if abs(mouse_pos.x - r.position.x) <= collision_size:
			bits |= DragBits.LEFT
		if abs(mouse_pos.y - r.position.y) <= collision_size:
			bits |= DragBits.TOP
		if abs(mouse_pos.x - r.end.x) <= collision_size:
			bits |= DragBits.RIGHT
		if abs(mouse_pos.y - r.end.y) <= collision_size:
			bits |= DragBits.BOTTOM
	
	return bits


func _forward_canvas_gui_input(event):
	update_overlays()
	
	if event is InputEventMouseButton:
		var mouse := event as InputEventMouseButton
		if mouse.button_index == MOUSE_BUTTON_LEFT:
			if mouse.pressed:
				drag_state = hitTest()
			else:
				drag_state = DragBits.NONE
			
			return true
	
	elif event is InputEventMouseMotion:
		
		var mouse_pos := current_object.get_local_mouse_position()
		var grid_size := current_object.grid_size
		
		if (drag_state & DragBits.LEFT) != 0:
			current_object.left = snappedi(mouse_pos.x, grid_size)
		if (drag_state & DragBits.TOP) != 0:
			current_object.top = snappedi(mouse_pos.y, grid_size)
		if (drag_state & DragBits.RIGHT) != 0:
			current_object.right = snappedi(mouse_pos.x, grid_size)
		if (drag_state & DragBits.BOTTOM) != 0:
			current_object.bottom = snappedi(mouse_pos.y, grid_size)
	
	return false
