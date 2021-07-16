#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1
varying highp vec2 qt_TexCoord;

uniform sampler2D qt_Texture;
uniform lowp float opacity;

void main()
{
    gl_FragColor = texture2D(qt_Texture, qt_TexCoord) * opacity;
}