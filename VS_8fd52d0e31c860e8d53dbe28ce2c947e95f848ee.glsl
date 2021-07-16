#line 1

    attribute highp   vec2      textureCoordArray; 
    varying   highp   vec2      textureCoords; 
    void setPosition(); 
    void main(void) 
    { 
        setPosition(); 
        textureCoords = textureCoordArray; 
    }

    attribute highp   vec4      vertexCoordsArray; 
    void setPosition(void) 
    { 
        gl_Position = vertexCoordsArray; 
    }
