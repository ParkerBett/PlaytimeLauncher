shader_type canvas_item;

// Control the grayscale effect: 1.0 = fully black & white, 0.0 = normal color
uniform float grayscale_intensity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    float gray = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));
    
    vec3 final_color = mix(tex_color.rgb, vec3(gray), grayscale_intensity);
    
    COLOR = vec4(final_color, tex_color.a);
}
