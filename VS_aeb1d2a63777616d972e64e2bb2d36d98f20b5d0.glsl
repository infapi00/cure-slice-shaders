#line 1

uniform highp mat4 u_modelMatrix;
uniform highp mat4 u_viewMatrix;
uniform highp mat4 u_projectionMatrix;

uniform highp mat4 u_normalMatrix;

attribute highp vec4 a_vertex;
attribute highp vec4 a_normal;
attribute highp vec2 a_uvs;

varying highp vec3 v_position;
varying highp vec3 v_vertex;
varying highp vec3 v_normal;

void main()
{
vec4 world_space_vert = u_modelMatrix * a_vertex;
gl_Position = u_projectionMatrix * u_viewMatrix * world_space_vert;

v_position = gl_Position.xyz;
v_vertex = world_space_vert.xyz;
v_normal = (u_normalMatrix * normalize(a_normal)).xyz;
}