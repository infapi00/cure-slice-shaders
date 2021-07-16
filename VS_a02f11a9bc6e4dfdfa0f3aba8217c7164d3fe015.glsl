#line 1

uniform highp mat4 u_modelMatrix;
uniform highp mat4 u_viewMatrix;
uniform highp mat4 u_projectionMatrix;

attribute highp vec4 a_vertex;
attribute lowp vec2 a_uvs;

varying lowp vec2 v_uvs;

void main()
{
gl_Position = u_projectionMatrix * u_viewMatrix * u_modelMatrix * a_vertex;
v_uvs = a_uvs;
}