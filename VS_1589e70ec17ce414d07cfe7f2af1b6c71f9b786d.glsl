#line 1
uniform highp mat4 qt_Matrix;

attribute highp vec4 qt_VertexPosition;
attribute highp vec2 qt_VertexTexCoord;

varying highp vec2 qt_TexCoord;

attribute highp float _qt_order;
uniform highp float _qt_zRange;
void main()
{
    qt_TexCoord = qt_VertexTexCoord;
    gl_Position = qt_Matrix * qt_VertexPosition;
    gl_Position.z = (gl_Position.z * _qt_zRange + _qt_order) * gl_Position.w;
}