//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;

uniform float rightSize;
uniform float waveSize;
uniform float speed;

void main()
{
	
	float sine = ((sin(v_vTexcoord.y*waveSize + u_time/speed) + 1.0) / 2.0) / rightSize + (1.0 - 1.0/rightSize);
	float color = floor(v_vTexcoord.x + sine);
	
    gl_FragColor = vec4(color,color,color,color);
}
