#line 1

uniform highp mat4 u_modelMatrix;
uniform highp mat4 u_viewMatrix;
uniform highp mat4 u_projectionMatrix;

attribute highp vec4 a_vertex; //Vertex coordinate.
void main()
{
gl_Position = u_projectionMatrix * u_viewMatrix * u_modelMatrix * a_vertex; //Transform the vertex coordinates with the model view projection.
}