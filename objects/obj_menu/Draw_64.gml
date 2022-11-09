timer += 1

draw_clear(c_white)

var text = "AOLIM2"
var text2 = "scrubware"

var dist = 90

var blorbsDuration = 100
var textDuration = 150
var menuStartTime = 1
var leaveStartTime = 130

var blorbsSize = 300

draw_set_font(fn_regonare_large)
draw_set_valign(fa_middle)
draw_set_halign(fa_left)

var _stringWidth = string_width(text)
var _stringHeight = string_height(text)

var totalWidth = _stringWidth + blorbsSize * 2 - dist * 2

var _alph = get_curve(ac_blobs_alpha, 0, timer / blorbsDuration)
var _alph2 = get_curve(ac_blobs_alpha, 0, timer / textDuration)

var _pos = get_curve(ac_blobs_move, 0, timer / blorbsDuration) * dist
var _pos2 = get_curve(ac_blobs_move, 0, timer / textDuration) * dist

draw_set_alpha(1)
draw_set_color(c_black)

var _circ_size = 1300
if exiting && exitTimer > leaveStartTime {
	
	if spawnTrigger = true {
		//uibase.clear()
		instance_create_depth(0,0,0,obj_main)
		spawnTrigger = false
	}
	
	leaveTimer ++
	
	_circ_size = 1300 * (1-get_curve(ac_blobs_alpha,0,(leaveTimer / 200)))
	
	_alph = get_curve(ac_blobs_alpha, 0, 1 - leaveTimer / 100)
	_alph2 = get_curve(ac_blobs_alpha, 0, 1 - leaveTimer / 100)
}

draw_circle((window_get_width() - totalWidth)/2,window_get_height()/2,_circ_size,false)

var _textAlpha = _alph2

var blorbX = window_get_width()/2 - _pos - totalWidth/2
var textX = window_get_width()/2 + _pos - totalWidth/2

draw_blorbs(blorbX, window_get_height()/2, blorbsSize, _alph)

draw_set_color(c_white)


var _offset = 6
draw_set_alpha(0.2 * _textAlpha)
draw_text(textX - _offset, window_get_height()/2 + _offset, text)

_offset = 3
draw_set_font(fn_regonare_small)
draw_text(textX - _offset, window_get_height()/2 + _offset + _stringHeight/2, text2)

draw_set_font(fn_regonare_large)
draw_set_alpha(1 * _textAlpha)
draw_text(textX, window_get_height()/2, text)

draw_set_font(fn_regonare_small)
draw_text(textX, window_get_height()/2 + _stringHeight/2, text2)

if timer >= menuStartTime
{
	var _width = 525
	
	var _curve = get_curve(ac_blobs_menu_move,0,menuTimer/200)
	var _curve2 = get_curve(ac_blobs_menu_move,0,menuTimer/400)
	
	var _alpha = _curve2
	
	if exiting = true {
		exitTimer ++
		
		//_rightLeave = get_curve(ac_blobs_menu_move,0,exitTimer/400) * _width + 10
		
		_curve = get_curve(ac_blobs_menu_move,0,1 - exitTimer/200)
		_curve2 = get_curve(ac_blobs_menu_move,0,1 - exitTimer/400)
		
		_alpha = get_curve(ac_blobs_menu_move,0,1 - exitTimer/100)
	}
	
	menuTimer += 1
	
	uniformWavyTime = shader_get_uniform(shd_wavy,"u_time")
	uniformRightSize = shader_get_uniform(shd_wavy,"rightSize")
	uniformWaveSize = shader_get_uniform(shd_wavy,"waveSize")
	uniformSpeed = shader_get_uniform(shd_wavy,"speed")
	
	var _surf = surface_create(1,1)
	
	
	
	var _rightSize = 10
	
	shader_set(shd_wavy)
	shader_set_uniform_f(uniformWavyTime,timer)
	shader_set_uniform_f(uniformRightSize,_rightSize)
	shader_set_uniform_f(uniformWaveSize,_curve2*12.5)
	shader_set_uniform_f(uniformSpeed,20.0)
	
	draw_surface_ext(_surf,window_width - _curve * _width, 0, _width, window_height, 0 ,c_white, 1)
	
	shader_reset()
	
	
	draw_set_alpha(_alpha)
	draw_set_color(c_black)
	draw_set_font(fn_regonare_large)
	draw_set_halign(fa_center)
	draw_set_valign(fa_bottom)
	
	var _xx = window_width - _width/2 + _width/_rightSize
	
	draw_text(_xx,window_height/4,"log in")
	
	if _alpha > 0 {
		uibase.draw(_xx - 300/2,window_height/4 + 10)
	}
	
} else {
	menuTimer = 0	
}