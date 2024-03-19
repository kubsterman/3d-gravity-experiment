shader_type sky;

uniform sampler2D noise;

void sky() {
	vec4 color = texture(noise, SKY_COORDS);
	
	if (color.r > 0.3){
		COLOR = color.rgb * vec3(0.1* color.r,0,0.2* color.b);
	}else if(color.g > 0.1){
		COLOR = color.rgb * vec3(0.1* color.r,0,0);
	}else if(color.b > 0.1){
		COLOR = vec3(1,1,1);
	}
		
}
