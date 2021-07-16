#line 1

uniform highp mat4 u_modelViewProjectionMatrix;
attribute highp vec4 a_vertex;
attribute highp vec2 a_uvs;

varying highp vec2 v_uvs;

void main()
{
gl_Position = u_modelViewProjectionMatrix * a_vertex;
v_uvs = a_uvs;
}