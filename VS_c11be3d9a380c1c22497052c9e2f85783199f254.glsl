#line 1
attribute highp vec4 vertexCoord;
attribute highp vec4 vertexColor;

uniform highp mat4 matrix;
uniform highp float opacity;

varying lowp vec4 color;

attribute highp float _qt_order;
uniform highp float _qt_zRange;
void main()
{
    gl_Position = matrix * vertexCoord;
    color = vertexColor * opacity;
    gl_Position.z = (gl_Position.z * _qt_zRange + _qt_order) * gl_Position.w;
}