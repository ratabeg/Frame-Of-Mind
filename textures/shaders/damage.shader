/* 
* damage shader
* flashes white while entity experiences damage
* flashes red for light colored enemies
*/
shader_type canvas_item; // declare shader as canvas

uniform vec4 flash: hint_color = vec4(1.0); // user interface for native gdScript
uniform float flashMod: hint_range(0.0,1.0) = 0; // allows dev to select color

// apply shader visuals using built-in function
void fragment(){
	vec4 color = texture(TEXTURE,UV); // apply shader to sprite UV value
	color.rgb = mix(color.rgb, flash.rgb, flashMod); // mix values
	COLOR = color;
}