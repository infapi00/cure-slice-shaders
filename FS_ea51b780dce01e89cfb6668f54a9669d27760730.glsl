
#version 320 es
#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 2
out highp vec4 frag_color;

void main()
{
frag_color = vec4(0.0, 0.0, 0.0, 1.0);
frag_color.r = float(gl_PrimitiveID % 0x100) / 255.0;
frag_color.g = float((gl_PrimitiveID / 0x100) % 0x100) / 255.0;
frag_color.b = float(0x1 + 2 * ((gl_PrimitiveID / 0x10000) % 0x80)) / 255.0;
// Don't use alpha for anything, as some faces may be behind others, an only the front one's value is desired.
// There isn't any control over the background color, so a signal-bit is put into the blue byte.
}