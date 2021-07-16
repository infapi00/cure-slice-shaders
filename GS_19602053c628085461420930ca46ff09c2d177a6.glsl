
#version 320 es
#line 2

uniform lowp int u_resolution;

uniform mediump mat4 u_viewMatrix;
uniform mediump mat4 u_projectionMatrix;

uniform mediump vec3 u_viewPosition;
uniform mediump vec3 u_lightPosition;

uniform lowp vec4 u_starts_color;
uniform int u_show_starts;

layout(lines) in;
layout(triangle_strip, max_vertices = 11) out;

in lowp vec4 v_color[];
in vec3 v_vertex[];
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

void outputVertex(const int index, const vec3 normal, const float x_offset, const float y_offset)
{
f_color = v_color[1];
f_normal = normal;
vec4 vertex_delta = gl_in[1].gl_Position - gl_in[0].gl_Position;
vec4 offset_vec = normalize(vec4(vertex_delta.z, 0.0, -vertex_delta.x, 0.0)) * x_offset;
offset_vec.y = y_offset;
gl_Position = viewProjectionMatrix * (gl_in[index].gl_Position + offset_vec);
EmitVertex();
}

void main()
{
if (v_color[1].a == 0.0) {
return;
}

viewProjectionMatrix = u_projectionMatrix * u_viewMatrix;

vec3 view_delta = normalize(u_viewPosition - (v_vertex[0] + v_vertex[1]) * 0.5); // camera to middle of line

float h_comp = length(view_delta.xz); // horizontal component
float v_comp = 1.0 - h_comp; // vertical component
float x_sign = -1.0;

// fiddle with sign of horizontal offset so that primitive is always tilting towards viewer
if (((v_vertex[1].x - v_vertex[0].x)*(u_viewPosition.z - v_vertex[0].z) - (v_vertex[1].z - v_vertex[0].z)*(u_viewPosition.x - v_vertex[0].x)) > 0.0) {
x_sign *= -1.0;
}
if (view_delta.y < 0.0) {
x_sign *= -1.0;
}

// x_offset is max when looking from above/below (i.e. v_comp is near 1.0) or when looking along line segment
float x_offset = v_line_width[1] * max(v_comp, abs(dot(normalize(v_vertex[1] - v_vertex[0]), view_delta)));
// y_offset is max when looking from side
float y_offset = v_line_height[1] * h_comp;

outputVertex(0, -view_delta, -x_sign * x_offset, -y_offset);
outputVertex(1, -view_delta, -x_sign * x_offset, -y_offset);
if (u_resolution > 0) {
outputVertex(0, view_delta, 0.0, 0.0);
outputVertex(1, view_delta, 0.0, 0.0);
view_delta = -view_delta;
}
outputVertex(0, view_delta, x_sign * x_offset, y_offset);
outputVertex(1, view_delta, x_sign * x_offset, y_offset);

EndPrimitive();

if ((u_show_starts == 1) && (v_prev_line_type[0] != 1.0) && (v_line_type[0] == 1.0)) {
float w = v_line_width[1] * 1.1;
float h = v_line_height[1];

outputStartVertex(normalize(vec3( 1.0,  1.0,  1.0)), vec4( w,  h,  w, 0.0)); // Front-top-left
outputStartVertex(normalize(vec3( 1.0,  1.0, -1.0)), vec4( w,  h, -w, 0.0)); // Back-top-left
outputStartVertex(normalize(vec3(-1.0,  1.0,  1.0)), vec4(-w,  h,  w, 0.0)); // Front-top-right
outputStartVertex(normalize(vec3(-1.0,  1.0, -1.0)), vec4(-w,  h, -w, 0.0)); // Back-top-right
outputStartVertex(normalize(vec3( 1.0,  1.0, -1.0)), vec4( w,  h, -w, 0.0)); // Back-top-left

EndPrimitive();
}
}