
#version 320 es
#line 2
uniform mediump mat4 u_modelMatrix;

uniform lowp float u_active_extruder;

uniform lowp mat4 u_extruder_opacity;  // currently only for max 16 extruders, others always visible

//uniform highp mat4 u_normalMatrix;

uniform int u_show_travel_moves;
uniform int u_show_helpers;
uniform int u_show_skin;
uniform int u_show_infill;

in highp vec4 a_vertex;
in lowp vec4 a_color;
in lowp vec4 a_material_color;
in highp vec4 a_normal;
in highp vec2 a_line_dim;  // line width and thickness
in highp float a_extruder;
in highp float a_line_type;

out lowp vec4 v_color;
out vec3 v_vertex;
out lowp float v_line_width;
out lowp float v_line_height;

//out highp mat4 v_view_projection_matrix;

out lowp vec4 f_color;
out vec3 f_normal;

void main()
{
vec4 v1_vertex = a_vertex;
v1_vertex.y -= a_line_dim.y * 0.5;  // half layer down

vec4 world_space_vert = u_modelMatrix * v1_vertex;
gl_Position = world_space_vert;
// shade the color depending on the extruder index stored in the alpha component of the color

v_color = vec4(0.4, 0.4, 0.4, 0.9);    // default color for not current layer

v_vertex = world_space_vert.xyz;
//v_normal = (u_normalMatrix * normalize(a_normal)).xyz;

if ((u_extruder_opacity[int(mod(a_extruder, 4.0))][int(a_extruder / 4.0)] == 0.0) ||
((u_show_travel_moves == 0) && ((a_line_type == 8.0) || (a_line_type == 9.0))) ||
((u_show_helpers == 0) && ((a_line_type == 4.0) || (a_line_type == 5.0) || (a_line_type == 7.0) || (a_line_type == 10.0) || a_line_type == 11.0)) ||
((u_show_skin == 0) && ((a_line_type == 1.0) || (a_line_type == 2.0) || (a_line_type == 3.0))) ||
((u_show_infill == 0) && (a_line_type == 6.0))) {
v_line_width = 0.0;
v_line_height = 0.0;
}
else if ((a_line_type == 8.0) || (a_line_type == 9.0)) {
v_line_width = 0.075;
v_line_height = 0.075;
}
else {
v_line_width = a_line_dim.x * 0.5;
v_line_height = a_line_dim.y * 0.5;
}

// for testing without geometry shader
f_color = v_color;
//f_normal = v_normal;
}