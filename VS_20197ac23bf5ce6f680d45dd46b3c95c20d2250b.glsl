#line 1
attribute highp vec4 vCoord;
uniform highp mat4 matrix;

attribute highp float _qt_order;
uniform highp float _qt_zRange;
void main()
{
    gl_Position = matrix * vCoord;
    gl_Position.z = (gl_Position.z * _qt_zRange + _qt_order) * gl_Position.w;
}
