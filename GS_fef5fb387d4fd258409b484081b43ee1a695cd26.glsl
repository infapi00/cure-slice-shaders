
#version 320 es
#line 2
uniform mediump mat4 u_viewMatrix;
uniform mediump mat4 u_projectionMatrix;
uniform mediump vec3 u_viewPosition;

layout(lines) in;
layout(triangle_strip, max_vertices = 4) out;

in lowp vec4 v_color[];
in vec3 v_vertex[];
in lowp float v_line_width[];
in lowp float v_line_height[];

out vec4 f_color;
out vec3 f_normal;

mediump mat4 viewProjectionMatrix;

void myEmitVertex(const int index, const mediump vec3 normal, const mediump vec4 pos_offset)
{
f_color = v_color[index];
f_normal = normal;
gl_Position = viewProjectionMatrix * (gl_in[index].gl_Position + pos_offset);
EmitVertex();
}

void main()
{
if (v_color[1].a == 0.0) {
return;
}

viewProjectionMatrix = u_projectionMatrix * u_viewMatrix;

mediump vec3 vertex_normal;
mediump vec4 vertex_offset;

vec3 view_delta = normalize(u_viewPosition - (v_vertex[0] + v_vertex[1]) * 0.5);
if (abs(view_delta.y) > 0.5) {
// looking from above or below
vec4 vertex_delta = gl_in[1].gl_Position - gl_in[0].gl_Position;
vertex_normal = normalize(vec3(vertex_delta.z, vertex_delta.y, -vertex_delta.x));
if (view_delta.y > 0.5) {
vertex_normal = -vertex_normal;
}
vertex_offset = vec4(vertex_normal * v_line_width[1], 0.0);
}
else {
// looking from the side
vertex_normal = vec3(0.0, 1.0, 0.0);
if (((v_vertex[1].x - v_vertex[0].x)*(u_viewPosition.z - v_vertex[0].z) - (v_vertex[1].z - v_vertex[0].z)*(u_viewPosition.x - v_vertex[0].x)) > 0.0) {
vertex_normal.y = -1.0;
}
vertex_offset = vec4(vertex_normal * v_line_height[1], 0.0);
}

myEmitVertex(0, vertex_normal, vertex_offset);
myEmitVertex(1, vertex_normal, vertex_offset);
myEmitVertex(0, -vertex_normal, -vertex_offset);
myEmitVertex(1, -vertex_normal, -vertex_offset);

EndPrimitive();
}