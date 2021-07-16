#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1

uniform mediump vec4 u_ambientColor;
uniform mediump vec4 u_diffuseColor;
uniform highp vec3 u_lightPosition;

uniform mediump float u_opacity;

varying highp vec3 v_vertex;
varying highp vec3 v_normal;

void main()
{
mediump vec4 finalColor = vec4(0.0);

/* Ambient Component */
finalColor += u_ambientColor;

highp vec3 normal = normalize(v_normal);
highp vec3 lightDir = normalize(u_lightPosition - v_vertex);

/* Diffuse Component */
highp float NdotL = clamp(abs(dot(normal, lightDir)), 0.0, 1.0);
finalColor += (NdotL * u_diffuseColor);

gl_FragColor = finalColor;
gl_FragColor.a = u_opacity;
}