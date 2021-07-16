#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1

#ifdef GL_ES
#extension GL_OES_standard_derivatives : enable
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif // GL_FRAGMENT_PRECISION_HIGH
#endif // GL_ES
uniform lowp vec4 u_plateColor;
uniform lowp vec4 u_gridColor0;
uniform lowp vec4 u_gridColor1;

varying lowp vec2 v_uvs;

void main()
{
vec2 coord = v_uvs.xy;

// Compute anti-aliased world-space minor grid lines
vec2 minorGrid = abs(fract(coord - 0.5) - 0.5) / fwidth(coord);
float minorLine = min(minorGrid.x, minorGrid.y);

vec4 minorGridColor = mix(u_plateColor, u_gridColor1, 1.0 - min(minorLine, 1.0));

// Compute anti-aliased world-space major grid lines
vec2 majorGrid = abs(fract(coord / 10.0 - 0.5) - 0.5) / fwidth(coord / 10.0);
float majorLine = min(majorGrid.x, majorGrid.y);

gl_FragColor = mix(minorGridColor, u_gridColor0, 1.0 - min(majorLine, 1.0));
}