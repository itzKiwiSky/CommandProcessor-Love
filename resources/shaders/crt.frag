extern vec2 inputSize;
extern vec2 textureSize;
#define distortion 0.2

vec2 radialDistortion(vec2 coord, const vec2 ratio)
{
    float offsety = 1.0 - ratio.y;
    coord.y -= offsety;
    coord /= ratio;
    
    vec2 cc = coord - 0.5;
    float dist = dot(cc, cc) * distortion;
    vec2 result = coord + cc * (1.0 + dist) * dist;
    
    result *= ratio;
    result.y += offsety;
    
    return result;
}
/*
vec4 checkTexelBounds(Image texture, vec2 coords, vec2 bounds)
{
    vec4 color = Texel(texture, coords) * 
    
    vec2 ss = step(coords, vec2(bounds.x, 1.0)) * step(vec2(0.0, bounds.y), coords);
    
    color.rgb *= ss.x * ss.y;
    color.a = step(color.a, ss.x * ss.y);
    
    return color;
}*/

vec4 checkTexelBounds(Image texture, vec2 coords, vec2 bounds)
{
    vec2 ss = step(coords, vec2(bounds.x, 1.0)) * step(vec2(0.0, bounds.y), coords);
    return Texel(texture, coords) * ss.x * ss.y;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
{
    vec2 coords = radialDistortion(texture_coords, inputSize / textureSize);
    
    vec4 texcolor = checkTexelBounds(texture, coords, vec2(inputSize.x / textureSize.x, 1.0 - inputSize.y / textureSize.y));
    texcolor.a = 1.0;
        

    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
        
        
    number noise = 0.01 * sin((2*3.14) * 5 * texture_coords.y - 4);
    number height = floor(texture_coords.y * 256);
        
    //This divides the image into two scan regions
    if (mod(height, 2) != 0)
    {
        color.r = 0.3;
        color.g = 0.8 - (floor(noise*160)/16);
        color.b = 1 - (floor(noise*160)/16);
        return Texel(texture, coords) * texcolor;
    }
    else 
    {
        pixel.r *= 1.2; 
        pixel.b = 0.5 * pixel.b;
        pixel.g *= 0.2;
        return texcolor;
    }
}