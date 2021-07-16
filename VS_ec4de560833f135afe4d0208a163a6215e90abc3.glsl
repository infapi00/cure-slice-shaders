
#version 320 es
#line 2
uniform mediump mat4 u_modelMatrix;

uniform lowp float u_active_extruder;
uniform lowp float u_max_feedrate;
uniform lowp float u_min_feedrate;
uniform lowp float u_max_thickness;
uniform lowp float u_min_thickness;
uniform lowp float u_max_line_width;
uniform lowp float u_min_line_width;
uniform lowp int u_layer_view_type;
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
in highp float a_prev_line_type;
in highp float a_line_type;
in highp float a_feedrate;
in highp float a_thickness;

out lowp vec4 v_color;
out vec3 v_vertex;
//out highp vec2 v_line_dim;
out mediump float v_line_width;
out mediump float v_line_height;
out mediump float v_prev_line_type;
out mediump float v_line_type;

out lowp vec4 f_color;
out vec3 f_normal;

vec4 feedrateGradientColor(float abs_value, float min_value, float max_value)
{
float value = (abs_value - min_value)/(max_value - min_value);
float red = value;
float green = 1.0-abs(1.0-4.0*value);
if (value > 0.375)
{
green = 0.5;
}
float blue = max(1.0-4.0*value, 0.0);
return vec4(red, green, blue, 1.0);
}

vec4 layerThicknessGradientColor(float abs_value, float min_value, float max_value)
{
float value = (abs_value - min_value)/(max_value - min_value);
float red = min(max(4.0*value-2.0, 0.0), 1.0);
float green = min(1.5*value, 0.75);
if (value > 0.75)
{
green = value;
}
float blue = 0.75-abs(0.25-value);
return vec4(red, green, blue, 1.0);
}

vec4 lineWidthGradientColor(float abs_value, float min_value, float max_value)
{
float value = (abs_value - min_value) / (max_value - min_value);
float red = value;
float green = 1.0 - abs(1.0 - 4.0 * value);
if(value > 0.375)
{
green = 0.5;
}
float blue = max(1.0 - 4.0 * value, 0.0);
return vec4(red, green, blue, 1.0);
}

void main()
{
vec4 v1_vertex = a_vertex;
if ((a_line_type == 8.0) || (a_line_type == 9.0))
v1_vertex.y += 0.05; // move line slightly above layer
else
v1_vertex.y -= a_line_dim.y * 0.5;  // half layer down

vec4 world_space_vert = u_modelMatrix * v1_vertex;
gl_Position = world_space_vert;
// shade the color depending on the extruder index stored in the alpha component of the color

switch (u_layer_view_type) {
case 0:  // "Material color"
v_color = a_material_color;
break;
case 1:  // "Line type"
v_color = vec4(vec3(a_color) * 2.0, a_color.a); // hack alert - compensate for 1/2 brightness used by ProcessSlicedLayersJob
break;
case 2:  // "Speed", or technically 'Feedrate'
v_color = feedrateGradientColor(a_feedrate, u_min_feedrate, u_max_feedrate);
break;
case 3:  // "Layer thickness"
v_color = layerThicknessGradientColor(a_line_dim.y, u_min_thickness, u_max_thickness);
break;
case 4:  // "Line width"
v_color = lineWidthGradientColor(a_line_dim.x, u_min_line_width, u_max_line_width);
break;
}

v_vertex = world_space_vert.xyz;
//v_normal = (u_normalMatrix * normalize(a_normal)).xyz;

if ((u_extruder_opacity[int(mod(a_extruder, 4.0))][int(a_extruder / 4.0)] == 0.0) ||
((u_show_travel_moves == 0) && ((a_line_type == 8.0) || (a_line_type == 9.0))) ||
((u_show_helpers == 0) && ((a_line_type == 4.0) || (a_line_type == 5.0) || (a_line_type == 7.0) || (a_line_type == 10.0) || a_line_type == 11.0)) ||
((u_show_skin == 0) && ((a_line_type == 1.0) || (a_line_type == 2.0) || (a_line_type == 3.0))) ||
((u_show_infill == 0) && (a_line_type == 6.0))) {
v_color.a = 0.0;
}

if ((a_line_type == 8.0) || (a_line_type == 9.0)) {
v_line_width = 0.05;
v_line_height = 0.05;
}
else {
v_line_width = a_line_dim.x * 0.5;
v_line_height = a_line_dim.y * 0.5;
}

v_prev_line_type = a_prev_line_type;
v_line_type = a_line_type;

// for testing without geometry shader
f_color = v_color;
//f_normal = v_normal;
}