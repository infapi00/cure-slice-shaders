#ifdef GL_KHR_blend_equation_advanced
#extension GL_ARB_fragment_coord_conventions : enable
#extension GL_KHR_blend_equation_advanced : enable
#endif
#ifndef GL_FRAGMENT_PRECISION_HIGH
#define highp mediump
#endif
#line 1

    lowp vec4 srcPixel(); 
    void main() 
    { 
        gl_FragColor = srcPixel(); 
    }

    varying   highp   vec2      textureCoords; 
    uniform           sampler2D imageTexture; 
    lowp vec4 srcPixel() 
    { 
return texture2D(imageTexture, textureCoords); 
}
