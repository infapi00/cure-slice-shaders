#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1
varying mediump vec2 qt_TexCoord0;
uniform highp float qt_Opacity;
uniform lowp sampler2D source;
uniform highp vec4 color;
void main() {
    highp vec4 pixelColor = texture2D(source, qt_TexCoord0);
    gl_FragColor = vec4(mix(pixelColor.rgb/max(pixelColor.a, 0.00390625), color.rgb/max(color.a, 0.00390625), color.a) * pixelColor.a, pixelColor.a) * qt_Opacity;
}
