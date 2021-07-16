#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1

uniform lowp vec4 u_color;

void main()
{
gl_FragColor = u_color; //Always use the uniform colour. The entire mesh will be the same colour.
}