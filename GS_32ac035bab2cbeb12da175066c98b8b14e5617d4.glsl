
#version 320 es
#line 2

uniform mediump mat4 u_viewMatrix;
uniform mediump mat4 u_projectionMatrix;

layout(lines) in;

layout(triangle_strip, max_vertices = 15) out;

in lowp vec4 v_color[];
in mediump float v_line_width[];
in mediump float v_line_height[];

out lowp vec4 f_color;
out vec3 f_normal;

mediump mat4 viewProjectionMatrix;

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
}
}