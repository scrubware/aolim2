// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_blorbs(x, y, size, alpha, time_speed = 200){

	static uniformTime = shader_get_uniform(shd_blobs,"iTime")
	static lavaSurface = -1
	static time = 0
	
	if alpha > 0 {
		time += 1/time_speed
	
		if !surface_exists(lavaSurface)
		{
			lavaSurface = surface_create(size, size)
		}


		surface_set_target(lavaSurface)
	
			draw_clear_alpha(c_white,alpha)
			draw_set_circle_precision(300)
			//draw_circle(size/2, size/2, size/2,false)
		
		surface_reset_target()
		//*/

		shader_set(shd_blobs)
		draw_set_color(c_white)
		shader_set_uniform_f(uniformTime,time)

		draw_surface(lavaSurface,x - size/2,y - size/2)

		shader_reset()
	}


}