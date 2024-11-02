extends EditorInspectorPlugin


var undo_redo_mgr:EditorUndoRedoManager


func _init(_undo_redo_mgr:EditorUndoRedoManager):
	undo_redo_mgr = _undo_redo_mgr


func _can_handle(object):
	return object is AABB2D


func _parse_group(object, group):
	return
	
	if group == "Rect":
		var button := Button.new()
		button.text = "set(10, 10, 200, 180)"
		
		var rect = Rect2()
		rect.position = Vector2(10, 10)
		rect.end = Vector2(200, 180)
		
		button.pressed.connect(func():
				undo_redo_mgr.create_action("setting(10, 10, 200, 180)", UndoRedo.MERGE_ENDS)	
				undo_redo_mgr.add_do_property(object, "rect", rect)
				undo_redo_mgr.add_undo_property(object, "rect", object.rect)
				undo_redo_mgr.commit_action())
		
		add_custom_control(button)
