#line 1
uniform highp mat4 matrix;
uniform highp vec2 textureScale;
uniform highp float dpr;

attribute highp vec4 vCoord;
attribute highp vec2 tCoord;

varying highp vec2 sampleCoord;

attribute highp float _qt_order;
uniform highp float _qt_zRange;
void main()
{
     sampleCoord = tCoord * textureScale;
     vec3 dprSnapPos = floor(vCoord.xyz * dpr + 0.5) / dpr;
     gl_Position = matrix * vec4(dprSnapPos, vCoord.w);
    gl_Position.z = (gl_Position.z * _qt_zRange + _qt_order) * gl_Position.w;
}
