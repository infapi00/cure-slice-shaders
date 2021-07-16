#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1
varying highp vec2 sampleCoord;

uniform lowp sampler2D _qt_texture;
uniform lowp vec4 color;

void main()
{
    gl_FragColor = color * texture2D(_qt_texture, sampleCoord).a;
}