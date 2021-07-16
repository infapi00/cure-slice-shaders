#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1
uniform lowp sampler2D source;
uniform lowp float qt_Opacity;
varying highp vec2 qt_TexCoord1;

void main() {
    gl_FragColor = texture2D(source, qt_TexCoord1) * qt_Opacity;
}
