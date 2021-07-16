
#version 320 es
#line 2
uniform highp mat4 u_modelMatrix;
uniform highp mat4 u_viewMatrix;
uniform highp mat4 u_projectionMatrix;

in highp vec4 a_vertex;

void main()
{
gl_Position = u_projectionMatrix * u_viewMatrix * u_modelMatrix * a_vertex;
}