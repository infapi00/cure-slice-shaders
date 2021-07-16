
#version 320 es
#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 2
#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif // GL_FRAGMENT_PRECISION_HIGH
#endif // GL_ES
in lowp vec4 f_color;
in vec3 f_normal;

out vec4 frag_color;

uniform mediump vec4 u_ambientColor;
uniform mediump vec4 u_minimumAlbedo;
uniform mediump vec3 u_lightPosition;

void main()
{
vec4 colour = u_minimumAlbedo + (f_color * (dot(f_normal, normalize(u_lightPosition)) * 0.5 + 0.7));
colour.a = f_color.a;
frag_color = colour;
}