shader_type spatial;

uniform float emissivity = 10;

void fragment() {
	
	EMISSION = vec3(emissivity,emissivity,emissivity);
}
