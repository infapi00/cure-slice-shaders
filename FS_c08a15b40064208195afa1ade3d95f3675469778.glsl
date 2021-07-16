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
uniform mediump vec4 u_specularColor;
uniform highp vec3 u_lightPosition;
uniform mediump float u_shininess;
uniform highp vec3 u_viewPosition;

uniform lowp float u_overhangAngle;
uniform lowp vec4 u_overhangColor;
uniform lowp float u_lowestPrintableHeight;
uniform lowp vec4 u_faceColor;
uniform highp int u_faceId;

varying highp vec3 f_vertex;
varying highp vec3 f_normal;

uniform lowp float u_renderError;

void main()
{
mediump vec4 finalColor = vec4(0.0);

// Ambient Component
finalColor += u_ambientColor;

highp vec3 normal = normalize(f_normal);
highp vec3 lightDir = normalize(u_lightPosition - f_vertex);

// Diffuse Component
highp float NdotL = clamp(abs(dot(normal, lightDir)), 0.0, 1.0);
finalColor += (NdotL * u_diffuseColor);

// Specular Component
// TODO: We should not do specularity for fragments facing away from the light.
highp vec3 reflectedLight = reflect(-lightDir, normal);
highp vec3 viewVector = normalize(u_viewPosition - f_vertex);
highp float NdotR = clamp(dot(viewVector, reflectedLight), 0.0, 1.0);
finalColor += pow(NdotR, u_shininess) * u_specularColor;

finalColor = (f_vertex.y >= 0.0 && -normal.y > u_overhangAngle) ? u_overhangColor : finalColor;

highp vec3 grid = vec3(f_vertex.x - floor(f_vertex.x - 0.5), f_vertex.y - floor(f_vertex.y - 0.5), f_vertex.z - floor(f_vertex.z - 0.5));
finalColor.a = (u_renderError > 0.5) && dot(grid, grid) < 0.245 ? 0.667 : 1.0;
if (f_vertex.y <= u_lowestPrintableHeight)
{
finalColor.rgb = vec3(1.0, 1.0, 1.0) - finalColor.rgb;
}

gl_FragColor = finalColor;
}