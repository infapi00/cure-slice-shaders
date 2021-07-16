#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1

uniform lowp vec4 u_color;
varying lowp vec4 v_color;

void main()
{
if(v_color != vec4(0.0, 0.0, 0.0, 1.0))
{
gl_FragColor = v_color;
}
else
{
gl_FragColor = u_color;
}
}