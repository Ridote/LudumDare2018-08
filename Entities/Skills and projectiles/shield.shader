shader_type canvas_item;
render_mode unshaded;

uniform vec4 color : hint_color;
uniform float shield_width = 0.02;
uniform float shield_radius = 0.35;
uniform float shield_vibrating = 1.0;

void fragment (){
	float radius = cos(TIME * shield_vibrating) / 70.0 + shield_radius;
	float width = shield_width;
	
	vec2 uv = UV - .5;
	float d = length(uv);
	
	float c = smoothstep(radius, radius-width, d + width);
	if(d > radius && d < radius + 0.1) c = smoothstep(radius, radius + 0.04, d + width);
	if(d > radius + 0.01) c = 1.0 - smoothstep(radius, radius-width - 0.5, d - width - 0.2);
	
	COLOR = vec4(color.rgb, 1.0 - c);
}
