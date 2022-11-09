// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_roundrect_width(x1,y1,x2,y2,rx,ry,thickness,outline_color = c_black, fill_color = noone) {
	
	var _width = x2 - x1 + 1
	var _height = y2 - y1 + 1
	
	if _width > 0 and _height > 0
	{
		if thickness > 1 {
			var _surf = surface_create(_width,_height)
		
			surface_set_target(_surf)
		
			draw_set_color(outline_color)
			draw_set_alpha(1)
		
			draw_roundrect_ext(0,0,_width,_height,rx,ry,false)
		
			if fill_color = noone {
			
				gpu_set_blendmode(bm_subtract)

			} else {
				draw_set_color(fill_color)	
			}
		
			draw_roundrect_ext(thickness,thickness,_width-thickness-1,_height-thickness-1,rx-thickness*pi/2,ry-thickness*pi/2,false)
		
			gpu_set_blendmode(bm_normal)
		
			surface_reset_target()
		
			draw_surface_ext(_surf,x1,y1,1,1,0,c_white,draw_get_alpha())
		
			surface_free(_surf)
		} else {
			draw_set_color(fill_color)
			draw_roundrect_ext(x1,y1,x2,y2,rx,ry,true)
			
			draw_set_color(outline_color)
			draw_roundrect_ext(x1,y1,x2,y2,rx,ry,true)
		}
	}

}