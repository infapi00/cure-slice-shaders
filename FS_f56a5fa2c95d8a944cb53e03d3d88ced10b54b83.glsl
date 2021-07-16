#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1

uniform mediump vec4 u_ambientColor;
uniform mediump vec4 u_diffuseColor1;
uniform mediump vec4 u_diffuseColor2;
uniform mediump vec4 u_specularColor;
uniform mediump float u_opacity;
uniform highp vec3 u_lightPosition;
uniform mediump float u_shininess;
uniform highp vec3 u_viewPosition;

uniform mediump float u_width;
uniform bool u_vertical_stripes;
uniform lowp float u_lowestPrintableHeight;

varying highp vec3 v_position;
varying highp vec3 v_vertex;
varying highp vec3 v_normal;

void main()
{
mediump vec4 finalColor = vec4(0.0);
mediump vec4 diffuseColor = u_vertical_stripes ?
(((mod(v_vertex.x, u_width) < (u_width / 2.)) ^^ (mod(v_vertex.z, u_width) < (u_width / 2.))) ? u_diffuseColor1 : u_diffuseColor2) :
((mod(((-v_vertex.x + v_vertex.y + v_vertex.z) * 4.), u_width) < (u_width / 2.)) ? u_diffuseColor1 : u_diffuseColor2);

/* Ambient Component */
finalColor += u_ambientColor;

highp vec3 normal = normalize(v_normal);
highp vec3 lightDir = normalize(u_lightPosition - v_vertex);

/* Diffuse Component */
highp float NdotL = clamp(abs(dot(normal, lightDir)), 0.0, 1.0);
finalColor += (NdotL * diffuseColor);

/* Specular Component */
/* TODO: We should not do specularity for fragments facing away from the light.*/
highp vec3 reflectedLight = reflect(-lightDir, normal);
highp vec3 viewVector = normalize(u_viewPosition - v_vertex);
highp float NdotR = clamp(dot(viewVector, reflectedLight), 0.0, 1.0);
finalColor += pow(NdotR, u_shininess) * u_specularColor;
if (v_vertex.y <= u_lowestPrintableHeight)
{
finalColor.rgb = vec3(1.0, 1.0, 1.0) - finalColor.rgb;
}

gl_FragColor = finalColor;
gl_FragColor.a = u_opacity;
}