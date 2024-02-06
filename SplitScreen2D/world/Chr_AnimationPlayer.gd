extends AnimationPlayer

static var default_value = null

# 走りのアニメーションを開始した！
# 頭の部分だけ、毎回すこし変化させてみる
func start_run():

	var anim:Animation = get_animation("run")
	var track_idx0 = anim.find_track(NodePath("Pivot/Torso/Head:position"), Animation.TYPE_VALUE)
	var track_idx1 = anim.find_track(NodePath("Pivot/Torso/Head:rotation"), Animation.TYPE_VALUE)
	var p:Vector2
	var r:float
	
	if default_value == null:
		p = anim.track_get_key_value(track_idx0, 0)
		r = anim.track_get_key_value(track_idx1, 0)
		default_value = [p, r]
	else:
		p = default_value[0]
		r = default_value[1]
	
	p.y += randf_range(-70, 5)
	p.x += randf_range(-10, 10)
	anim.track_set_key_value(track_idx0, 1, p)
	p.y += randf_range(-70, 5)
	p.x += randf_range(-10, 10)
	anim.track_set_key_value(track_idx0, 3, p)
	
	r += PI * randf_range(-0.08, 0.16)
	anim.track_set_key_value(track_idx1, 1, r)
	r += PI * randf_range(-0.08, 0.16)
	anim.track_set_key_value(track_idx1, 3, r)
