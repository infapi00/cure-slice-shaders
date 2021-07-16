
#version 320 es
#line 2

uniform mediump mat4 u_viewMatrix;
uniform mediump mat4 u_projectionMatrix;

uniform lowp vec4 u_starts_color;
uniform int u_show_starts;

layout(lines) in;

layout(triangle_strip, max_vertices = 15) out;

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
f_color = vec4(1.0, 1.0, 0.0, 0.0);
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
}