#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1

uniform mediump vec4 u_ambientColor;
uniform mediump vec4 u_diffuseColor;
uniform highp vec3 u_lightPosition;
uniform highp vec3 u_viewPosition;
uniform mediump float u_opacity;
uniform sampler2D u_texture;

varying highp vec3 v_vertex;
varying highp vec3 v_normal;
varying highp vec2 v_uvs;

void main()
{
mediump vec4 final_color = vec4(0.0);

/* Ambient Component */
final_color += u_ambientColor;

highp vec3 normal = normalize(v_normal);
highp vec3 light_dir = normalize(u_lightPosition - v_vertex);

/* Diffuse Component */
highp float n_dot_l = clamp(dot(normal, light_dir), 0.0, 1.0);
final_color += (n_dot_l * u_diffuseColor);

final_color.a = u_opacity;

lowp vec4 texture = texture2D(u_texture, v_uvs);
final_color = mix(final_color, texture, texture.a);

gl_FragColor = final_color;
}