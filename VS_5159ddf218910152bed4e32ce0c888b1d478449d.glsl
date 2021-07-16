#line 1
uniform highp mat4 qt_Matrix;

attribute highp vec4 qt_Vertex;
attribute highp vec2 qt_MultiTexCoord0;

varying highp vec2 qt_TexCoord0;

attribute highp float _qt_order;
uniform highp float _qt_zRange;
void main()
{
    qt_TexCoord0 = qt_MultiTexCoord0;
    gl_Position = qt_Matrix * qt_Vertex;
    gl_Position.z = (gl_Position.z * _qt_zRange + _qt_order) * gl_Position.w;
}