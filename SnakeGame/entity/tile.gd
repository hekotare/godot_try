class_name Tile extends Area2D


var tex_head:Texture2D = load("res://icon.svg")
var head:bool = false
var color:Color = Color()


func _ready():
	color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1))


func _draw():
	#var mat:Transform2D = get_global_transform_with_canvas()
	#mat = mat.affine_inverse()
	
	# テクスチャの大きさを１つのセルに合わせる
	var w:float = 1.0
	var h:float = 1.0
	
	# テクスチャを描画するときは、描画サイズが１になるようにスケーリングする
	if head:
		w = Global.CELL_SIZE / tex_head.get_height()
		h = Global.CELL_SIZE / tex_head.get_width()
	
	# ワールド座標系でセルサイズ分を拡大しているので、描画ではセルサイズ分縮小して打ち消す
	draw_set_transform(Vector2(), 0.0, Vector2(w/Global.CELL_SIZE, h/Global.CELL_SIZE))
	
	if head:
		draw_texture(tex_head, Vector2())
	else:
		var ofs:int = 1
		draw_rect(Rect2(ofs, ofs, Global.CELL_SIZE - ofs * 2, Global.CELL_SIZE - ofs * 2), color)
