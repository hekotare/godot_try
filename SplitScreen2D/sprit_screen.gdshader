shader_type canvas_item;

uniform bool is_split;
uniform sampler2D viewport1:source_color;
uniform sampler2D viewport2:source_color;
uniform vec2 to;
uniform float split_line_tickness;

float dot(vec2 a, vec2 b) 
{
  return a.x * b.x + a.y * b.y;
}

void fragment() {
	
	// 分割なし
	if (is_split == false) {
		COLOR.rgba = texture(viewport1, UV + vec2(0.0, 0.0)).rgba;
	} else {
		// 画面分割の描画
		vec2 texture_size = vec2(textureSize(viewport1, 0));
		float d = dot(to, (UV - 0.5) * texture_size);
		
		if (0.0 <= d) {
			COLOR.rgba = texture(viewport1, UV).rgba;
		} else {
			COLOR.rgba = texture(viewport2, UV).rgba;
		}
		
		// 分割線の描画
		float d2 = split_line_tickness * 0.5 - abs(d);
		if (0.0 <= d2) {
			COLOR.rgba = mix(COLOR.rgba, vec4(0.0, 0.0, 0.0, 1.0), d2 / (split_line_tickness * 0.5));
		}
	}
}
