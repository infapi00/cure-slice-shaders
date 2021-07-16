
#version 320 es
#line 2

uniform mediump mat4 u_viewMatrix;
uniform mediump mat4 u_projectionMatrix;

uniform lowp vec4 u_starts_color;
uniform int u_show_starts;

layout(lines) in;

#define HAVE_POINTY_ENDS 0

#if HAVE_POINTY_ENDS
layout(triangle_strip, max_vertices = 31) out;
#else
layout(triangle_strip, max_vertices = 15) out;
#endif

in lowp vec4 v_color[];
in mediump float v_line_width[];
in mediump float v_line_height[];
in mediump float v_prev_line_type[];
in mediump float v_line_type[];

out lowp vec4 f_color;
out vec3 f_normal;

mediump mat4 viewProjectionMatrix;

void outputStartVertex(const vec3 normal, const vec4 offset)
{
f_color = u_starts_color;
f_normal = normal;
gl_Position = viewProjectionMatrix * (gl_in[0].gl_Position + offset);
EmitVertex();
}

void outputVertex(const int index, const vec3 normal, const vec4 offset)
{
f_color = v_color[1];
f_normal = normal;
gl_Position = viewProjectionMatrix * (gl_in[index].gl_Position + offset);
EmitVertex();
}

void outputEdge(const vec3 normal, const vec4 offset)
{
outputVertex(0, normal, offset);
outputVertex(1, normal, offset);
}

void main()
{
if (v_color[1].a != 0.0) {

viewProjectionMatrix = u_projectionMatrix * u_viewMatrix;

vec3 vertex_delta = gl_in[1].gl_Position.xyz - gl_in[0].gl_Position.xyz;
vec3 normal_h = normalize(vec3(vertex_delta.z, vertex_delta.y, -vertex_delta.x));
vec3 normal_v = vec3(0.0, 1.0, 0.0);
vec4 offset_h = vec4(normal_h * v_line_width[1], 0.0);
vec4 offset_v = vec4(normal_v * v_line_height[1], 0.0);

outputEdge(-normal_h, -offset_h);
outputEdge(normal_v, offset_v);
outputEdge(normal_h, offset_h);
outputEdge(-normal_v, -offset_v);
outputEdge(-normal_h, -offset_h);
EndPrimitive();

#if HAVE_POINTY_ENDS
if (v_line_height[1] > 0.01)
{
vertex_delta = normalize(vertex_delta);
vec4 offset_point = vec4(vertex_delta * v_line_width[1], 0.0);

outputVertex(0, -normal_h, -offset_h);
outputVertex(0, -vertex_delta, -offset_point);
outputVertex(0, normal_v, offset_v);
outputVertex(0, normal_h, offset_h);
EndPrimitive();

outputVertex(0, normal_h, offset_h);
outputVertex(0, -vertex_delta, -offset_point);
outputVertex(0, -normal_v, -offset_v);
outputVertex(0, -normal_h, -offset_h);
EndPrimitive();

outputVertex(1, -normal_h, -offset_h);
outputVertex(1, vertex_delta, offset_point);
outputVertex(1, normal_v, offset_v);
outputVertex(1, normal_h, offset_h);
EndPrimitive();

outputVertex(1, normal_h, offset_h);
outputVertex(1, vertex_delta, offset_point);
outputVertex(1, -normal_v, -offset_v);
outputVertex(1, -normal_h, -offset_h);
EndPrimitive();
}
#endif

if ((u_show_starts == 1) && (v_prev_line_type[0] != 1.0) && (v_line_type[0] == 1.0)) {
float w = v_line_width[1] * 1.1;
float h = v_line_height[1];
#if 1
outputStartVertex(normalize(vec3( 1.0,  1.0,  1.0)), vec4( w,  h,  w, 0.0)); // Front-top-left
outputStartVertex(normalize(vec3( 1.0,  1.0, -1.0)), vec4( w,  h, -w, 0.0)); // Back-top-left
outputStartVertex(normalize(vec3(-1.0,  1.0,  1.0)), vec4(-w,  h,  w, 0.0)); // Front-top-right
outputStartVertex(normalize(vec3(-1.0,  1.0, -1.0)), vec4(-w,  h, -w, 0.0)); // Back-top-right
outputStartVertex(normalize(vec3( 1.0,  1.0, -1.0)), vec4( w,  h, -w, 0.0)); // Back-top-left
#else
float z = 0.0;
outputStartVertex(normalize(vec3( 1.0, -1.0,  1.0)), vec4(  w, -h,  w, z)); // Front-bottom-left
outputStartVertex(normalize(vec3(   z,  1.0, -1.0)), vec4(  z,  h, -w, z)); // Back-top-middle
outputStartVertex(normalize(vec3(   z,  1.0,  1.0)), vec4(  z,  h,  w, z)); // Front-top-middle
outputStartVertex(normalize(vec3(-1.0, -1.0,  1.0)), vec4( -w, -h,  w, z)); // Front-bottom-right
outputStartVertex(normalize(vec3(   z,  1.0, -1.0)), vec4(  z,  h, -w, z)); // Back-top-middle
#endif
EndPrimitive();
}
}
}