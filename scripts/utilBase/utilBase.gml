
// Feather disable GM1064
// Feather disable GM2017
// Feather disable GM1033
;

// CLASSES

function User(name,portrait,color) constructor {
	
	self.name = name
	self.portrait = portrait
	self.color = color
	
}

function Time(month=current_month,day=current_day,year=current_year,hour=current_hour,minute=current_minute) constructor {
	self.month = month
	self.day = day
	self.year = year
	
	self.hour = hour
	self.minute = minute
	
	toString = function() {
		return string(month) + "/" + string(day) + "/" + string(year) + " - " + string((hour-1) % 12 + 1) + ":" + string(minute) + (hour div 12 = 1 ? " PM" : " AM")
	}
}


// SCRIPTS

function array_top(_array) {
	return array_get(_array,array_length(_array)-1)	
}

function draw_sprite_outline(sprite,index,x,y,xscale,yscale,rot,color,alpha,thickness = 2, precision = 7){

	for (var i = 0; i < precision; i ++)
	{
		var dx = lengthdir_x(thickness,i * (360 / precision))
		var dy = lengthdir_y(thickness,i * (360 / precision))
		draw_set_color(color)
		draw_sprite_ext(sprite,index, x + dx - 1, y + dy - 1, xscale,yscale,rot,color,alpha)
	}

}

function draw_rectangle_width(x1,y1,x2,y2,width,corners = true) {
	
	if corners = false {
		draw_line_width(x1,y1-width/2,x2+width,y1-width/2,width) // top
		draw_line_width(x1-width/2,y1-width,x1-width/2,y2,width) // left
		draw_line_width(x1-width,y2+width/2,x2,y2+width/2,width) // bottom
		draw_line_width(x2+width/2,y1,x2+width/2,y2+width,width) // right
	} else {
		draw_line_width(x1+width,y1+width/2,x2-width,y1+width/2,width) // top
		draw_line_width(x1+width/2,y1+width,x1+width/2,y2-width,width) // left
		draw_line_width(x1+width,y2-width/2,x2-width,y2-width/2,width) // bottom
		draw_line_width(x2-width/2,y1+width,x2-width/2,y2-width,width) // right
		
		var angle
		var precision = 50
		var positions = [[x1,y1,1,1],[x1,y2,1,-1],[x2,y2,-1,-1],[x2,y1,-1,1]]
		for (var j = 0; j < 4; j ++)
		{
			angle = 90 * (j + 1)
			draw_primitive_begin(pr_trianglefan)
			draw_vertex(positions[j][0] + width * positions[j][2], positions[j][1] + (width * positions[j][3] + 1))
		
				for (var i = 0; i <= (0.25 * precision) + 1; i++) {
					var len = (i * (360 / precision)) + angle
				    var tx = lengthdir_x(width, len)
				    var ty = lengthdir_y(width, len)
				    draw_vertex(positions[j][0] + width * positions[j][2] + tx, positions[j][1] + (width * positions[j][3] + 1) + ty)
				}
			
			draw_primitive_end()
		}
	}
	
	/*
	draw_set_color(c_aqua)
	draw_circle(x1,y1,3,false)
	draw_circle(x1,y2,3,false)
	draw_circle(x2,y1,3,false)
	draw_circle(x2,y2,3,false)
	*/
}
	
function get_curve(curve,index,position){
	var _struct = animcurve_get(curve)
	var _channel = animcurve_get_channel(_struct,index)
	var _value = animcurve_channel_evaluate(_channel,position)
	return _value
}

