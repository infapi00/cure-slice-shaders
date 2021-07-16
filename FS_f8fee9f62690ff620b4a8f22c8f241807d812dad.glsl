#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1
uniform highp sampler2D source;
uniform lowp float qt_Opacity;
uniform mediump float spread;
uniform highp vec2 dirstep;
uniform lowp vec4 color;
uniform lowp float thickness;

varying highp vec2 qt_TexCoord0;

void main() {
    mediump float result = 0.0;
    highp vec2 pixelStep = dirstep * spread;
    result += float(2.49355e-39) * texture2D(source, qt_TexCoord0 + pixelStep * float(-4)).a;
    result += float(1.93068e-22) * texture2D(source, qt_TexCoord0 + pixelStep * float(-3)).a;
    result += float(2.23462e-10) * texture2D(source, qt_TexCoord0 + pixelStep * float(-2)).a;
    result += float(0.00386635) * texture2D(source, qt_TexCoord0 + pixelStep * float(-1)).a;
    result += float(1) * texture2D(source, qt_TexCoord0 + pixelStep * float(0)).a;
    result += float(0.00386635) * texture2D(source, qt_TexCoord0 + pixelStep * float(1)).a;
    result += float(2.23462e-10) * texture2D(source, qt_TexCoord0 + pixelStep * float(2)).a;
    result += float(1.93068e-22) * texture2D(source, qt_TexCoord0 + pixelStep * float(3)).a;
    result += float(2.49355e-39) * texture2D(source, qt_TexCoord0 + pixelStep * float(4)).a;
    const mediump float wSum = float(1.00773);
    gl_FragColor = mix(vec4(0), color, clamp((result / wSum) / thickness, 0.0, 1.0)) * qt_Opacity;
}
