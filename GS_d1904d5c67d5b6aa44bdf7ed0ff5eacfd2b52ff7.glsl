
#version 320 es
#line 2

// GS is needed on the PI 4 because gl_PrimitiveID is not set implicitly
// can remove this GS when they get around to implementing more of 3.2

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
gl_PrimitiveID = gl_PrimitiveIDIn;
gl_Position = gl_in[0].gl_Position;
EmitVertex();
gl_Position = gl_in[1].gl_Position;
EmitVertex();
gl_Position = gl_in[2].gl_Position;
EmitVertex();
}