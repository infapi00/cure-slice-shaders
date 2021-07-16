#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif // GL_FRAGMENT_PRECISION_HIGH
#endif // GL_ES
uniform sampler2D u_layer0;
uniform sampler2D u_layer1;
uniform sampler2D u_layer2;

uniform vec2 u_offset[9];

uniform vec4 u_background_color;
uniform float u_outline_strength;
uniform vec4 u_outline_color;

varying vec2 v_uvs;

float kernel[9];

const vec3 x_axis = vec3(1.0, 0.0, 0.0);
const vec3 y_axis = vec3(0.0, 1.0, 0.0);
const vec3 z_axis = vec3(0.0, 0.0, 1.0);

void main()
{
// blur kernel
kernel[0] = 0.0; kernel[1] = 1.0; kernel[2] = 0.0;
kernel[3] = 1.0; kernel[4] = -4.0; kernel[5] = 1.0;
kernel[6] = 0.0; kernel[7] = 1.0; kernel[8] = 0.0;

vec4 result = u_background_color;

vec4 main_layer = texture2D(u_layer0, v_uvs);
vec4 selection_layer = texture2D(u_layer1, v_uvs);
vec4 layerview_layer = texture2D(u_layer2, v_uvs);

result = main_layer * main_layer.a + result * (1.0 - main_layer.a);
result = layerview_layer * layerview_layer.a + result * (1.0 - layerview_layer.a);

vec4 sum = vec4(0.0);
for (int i = 0; i < 9; i++)
{
vec4 color = vec4(texture2D(u_layer1, v_uvs.xy + u_offset[i]).a);
sum += color * (kernel[i] / u_outline_strength);
}

if((selection_layer.rgb == x_axis || selection_layer.rgb == y_axis || selection_layer.rgb == z_axis))
{
gl_FragColor = result;
}
else
{
gl_FragColor = mix(result, u_outline_color, abs(sum.a));
}
}