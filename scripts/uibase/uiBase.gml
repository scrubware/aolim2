
// Feather disable GM1064
// Feather disable GM2017
// Feather disable GM1033
;

#macro window_width window_get_width()
#macro window_height window_get_height()
#macro unassigned -1
#macro horizontal 0
#macro vertical 1
#macro print show_debug_message

#macro X 0
#macro Y 1
#macro X1 0
#macro Y1 1
#macro X2 2
#macro Y2 3

function UiBase() constructor {

	static activeFrame = unassigned
	static windows = []
	static draggingWindow = false
	static elementScope = []
	
	static storedScope = []
	
	static minimumDistanceToEdge = 10
	
	static defaultColorSettings = {
		background : #FFFFFF,
		windowBackground : #FFFFFF,
		notification : #fc3254,
		windowOutline : #000000,
		text : #000000,
		icon : #cec9b5,
		draggerActive : c_ltgray,
		draggerIdle : c_dkgray,
		chatWindow : [ #a7dd56, #e0b145, #48d6b7, #ad5ee5 ],
	}

	defaultPadding = 10
	
	colorSettings = defaultColorSettings

	add_to_windows = function(frame) {
		array_insert(windows,0,frame)
	}

	set_active_frame = function(frame) {
		activeFrame = frame
	}

	set_color_settings = function(color_settings_struct) {
		colorSettings = color_settings_struct	
	}
	
	get_color_settings = function() {
		return colorSettings
	}

	add_to_element_scope = function(frame) {
		array_push(elementScope,frame)
	}
	
	pop_element_scope = function() {
		array_pop(elementScope)
	}
	
	new_temporary_scope = function() {
		storedScope = elementScope
		elementScope = []
	}
	
	exit_temporary_scope = function() {
		elementScope = storedScope
		storedScope = []
	}
	
	get_current_window = function() {
		return array_top(windows)	
	}
	
	get_element_scope_length = function() {
		return array_length(elementScope)	
	}
	
	get_element_scope_top = function() {
		return array_top(elementScope)	
	}
	
	default_color_settings = function() {
		colorSettings = defaultColorSettings
	}
	
	get_minimum_distance_to_edge = function() {
		return minimumDistanceToEdge	
	}

	step = function()
	{
		
		if activeFrame != unassigned {
			activeFrame.step()
		}

		// PROCESS WINDOWS
		var _clickedThisFrame = false
		var _newArray = windows
		for (var i = 0; i < array_length(windows); i ++)
		{
			var _frame = windows[i]
			var _x = _frame.winX
			var _y = _frame.winY
	
			var _w = _frame.width-2
			var _h = _frame.height-2
	
			if point_in_rectangle(mouse_x,mouse_y,_x,_y,_x+_w,_y+_h) && _clickedThisFrame = false
			{
				if mouse_check_button_pressed(mb_left)
				{
					_clickedThisFrame = true
			
					activeFrame = _frame
			
					if _frame.displacing = true {
				
						var _array = windows[i]
						array_delete(_newArray,i,1)
						array_insert(_newArray,0,_array)
			
					}
			
					if _frame.movable = true {
						draggingWindow = _frame
				
						initial_window_x = _x
						initial_window_y = _y
			
						initial_mouse_x = mouse_x
						initial_mouse_y = mouse_y
			
					}
				}
			}
	
			if draggingWindow = _frame 
			{
				_x = clamp(initial_window_x + mouse_x - initial_mouse_x, minimumDistanceToEdge + 1, window_width - _w - minimumDistanceToEdge)
				_y = clamp(initial_window_y + mouse_y - initial_mouse_y, minimumDistanceToEdge + 1, window_height - _h - minimumDistanceToEdge)
		
				if mouse_check_button_released(mb_left)
				{
					draggingWindow = -1	
				}
		
				_newArray[0].winX = _x
				_newArray[0].winY = _y
			} else {
	
				_newArray[i].winX = _x
				_newArray[i].winY = _y
	
			}
		}
		windows = _newArray
	}

	drawBackground = function() {
		draw_clear(colorSettings.background)	
	}

	draw = function(x,y)
	{
		


		// DRAW THE TOP LEVEL FRAMES IN DEPTH ORDER
		for (var i = array_length(windows) - 1; i >= 0; i --)
		{
			var _frame = windows[i]
			_frame.draw(x + _frame.winX, y + _frame.winY)
		}
	}
	
	clear = function()
	{
		activeFrame = unassigned
		windows = []
		draggingWindow = false
		elementScope = []
	
		storedScope = []
	
		defaultPadding = 10
	
		colorSettings = {
			background : #FFFFFF,
			windowBackground : #FFFFFF,
			notification : #fc3254,
			windowOutline : #000000,
			text : #000000,
			icon : #cec9b5,
			draggerActive : c_ltgray,
			draggerIdle : c_dkgray
		}
	}
}

// Components

function Element(_padding) : UiBase() constructor {
	
	//uibase = new UiBase()
	//colorSettings = uibase.get_color_settings()
	onLink = function() {}
	
	if get_element_scope_length() > 0 {
		if _padding != unassigned {
			get_element_scope_top().addElement(self,_padding)
		} else {
			get_element_scope_top().addElement(self)
		}
	} else {
		self.parentFrame = unassigned
	}
	
	step = function() {}
	
	draw = function(x,y) { return [x,y] }
	
	isWindow = function() { 
		return ((parentFrame == unassigned) ? true : false) 
	}
	
	adjustCursor = function(x,y) {
		switch parentFrame.elementDirection
		{
			case horizontal:
				return adjustCursorX(x,y)
				break
			case vertical:
				return adjustCursorY(x,y)
				break
		}
	}
	adjustCursorX = function(x,y) { return [x,y] }
	adjustCursorY = function(x,y) { return [x, y] }
		
	move = function(x,y) { return [x,y] }
	
	onLink = function() {}
	
	
}

function Frame(width, height, thickness = 0, element_padding = 5, _padding = unassigned) : Element(_padding) constructor {
	
	winX = 0
	winY = 0
	
	// Make sure we're in the window list and we're in the new scope.
	
	add_to_element_scope(self)
	if parentFrame = unassigned {
		add_to_windows(self)
	}
	
	idealWidth = width
	idealHeight = height
	self.width = idealWidth
	self.height = idealHeight
	
	self.thickness = thickness
	
	color = colorSettings.windowOutline
	
	self.elementPadding = element_padding
	
	elements = []
	elementStartDirection = vertical
	
	margin = [5,5]
	paddingList = []
	
	drawCursor = [0,0]
	
	paddedWidth = 0
	paddedHeight = 0
	
	// Top level frame variables for window control
	movable = true
	displacing = true
	
	cornerRounding = 0
	
	backgroundColor = colorSettings.windowBackground
	
	updateIdealSize = function(width = idealWidth, height = idealHeight) {
		idealWidth = width
		idealHeight = height
	}
	
	static updateFrameAnchor = function(x,y) {
		
		updateIdealSize()
		
		// TODO: fix error. not detecting that the item is a Window when in the new temporary scope hnasefikbdfnaolfjbalkjsbfD
		
		var x1;
		var y1;
		var x2;
		var y2;
		
		if isWindow() {
			
			var _min = get_minimum_distance_to_edge()
			
			x1 = clamp(x, _min, window_width - idealWidth - _min)
			y1 = clamp(y, _min, window_height - idealHeight - _min)
			x2 = x1 + idealWidth
			y2 = y1 + idealHeight
			
		} else {
			
			rootParent = get_current_window()
			
			x1 = max(x, rootParent.margin[X])
			y1 = max(y, rootParent.margin[Y])
			x2 = min(x + idealWidth, window_width -  rootParent.margin[X], parentFrame.frameAnchor[X2])
			y2 = min(y + idealHeight, window_height -  rootParent.margin[Y], parentFrame.frameAnchor[Y2])
		}
		
		width = x2 - x
		height = y2 - y
		
		paddedWidth = width - margin[X]
		paddedHeight = height - margin[Y]
		
		frameAnchor = [ x1, y1, x2 - parentFrame.margin[X], y2 - parentFrame.margin[Y]]
		
		return frameAnchor
	}
	
	draw = function(x,y) {

		drawSelf(x,y)
		drawElements(x,y)
		
		return adjustCursor(x,y)
	}
	drawSelf = function(x,y) {
		
		var ank = updateFrameAnchor(x,y)
		
		/*
		if cornerRounding > 0 {
		
			draw_roundrect_width(ank[X1],ank[Y1],ank[X2],ank[Y2],30,30,thickness)
		
		} else {
		*/
			draw_set_color(backgroundColor)
			draw_rectangle(ank[X1],ank[Y1],ank[X2],ank[Y2],false)
		
			draw_set_color(color)
			draw_rectangle_width(ank[X1],ank[Y1],ank[X2],ank[Y2],thickness,false)
			
		//}
	}
	static drawElements = function(x,y) {
		
		updateFrameAnchor(x,y)
		
		elementDirection = elementStartDirection
		
		drawCursor = [ x, y ]		// set the cursor position
		addCursorPadding(margin)		// adjust for the margin of the frame
		
		// perform draw calls and add cursor padding for all the elements.
		for (var i = 0; i < array_length(elements); i ++) {
			drawCursor = elements[i].draw(drawCursor[X],drawCursor[Y])
			addCursorPaddingDir(paddingList[i])
		}
	}
	
	addElement = function(element,padding=elementPadding) {
		array_push(elements,element)
		array_push(paddingList,padding)
		element.parentFrame = self
		
		element.onLink()
		
		return element
	}
	
	static addCursorPaddingX = function(pad = elementPadding) {
		drawCursor[X] += pad
	}
	static addCursorPaddingY = function(pad = elementPadding) {
		drawCursor[Y] += pad
	}
	static addCursorPadding = function(pad = [elementPadding, elementPadding]) {
		drawCursor[X] += pad[X]
		drawCursor[Y] += pad[Y]
	}
	static addCursorPaddingDir = function(pad = elementPadding) {
		drawCursor[ (elementDirection = horizontal ? X : Y) ] += pad
	}
	
	adjustCursorX = function(x,y) {
		return [x + width, y]
	}
	adjustCursorY = function(x,y) {
		return [x, y + height]
	}
		
	
	
	
	step = function() {
		stepSelf()
		stepElements()
	}
	stepSelf = function() {
			
	}
	stepElements = function() {
		for (var i = 0; i < array_length(elements); i ++) {
			drawCursor = elements[i].step()
		}
	}
}

function TextElement(text, _padding = unassigned) : Element(_padding) constructor {
	
	self.text = text
	
	color = c_black
	alpha = 1
	animation_speed = 0.5
	wrapWidth = -1
	
	draw = function(x,y) {
		
		pos = move(x,y)
		
		draw_set_color(c_white)
		scribbleText = scribble(text).starting_format("fn_bahnscrift",colorSettings.text).animation_speed(0.5).wrap(wrapWidth)
		scribbleText.draw(round(pos[X]),round(pos[Y]))
		return adjustCursor(x,y)
	}
	
	adjustCursorX = function(x,y) {
		return [x + scribbleText.get_width(), y]
	}
	adjustCursorY = function(x,y) {
		return [x, y + scribbleText.get_height()]
	}
	
	setText = function(text) {
		
		
		scribbleText = scribble(text)
	}
	
	setText(text)
}

function Divider(thickness = 5, spacing = 0, _padding = unassigned) : Element(_padding) constructor {
	
	self.thickness = thickness
	self.spacing = spacing
	
	draw = function(x,y) {
		
		var x1;
		var y1;
		var x2;
		var y2;
		
		draw_set_color(parentFrame.color)
		if parentFrame.elementDirection = vertical {
			x1 = parentFrame.frameAnchor[X1] + spacing
			y1 = y
			x2 = parentFrame.frameAnchor[X2] - spacing
			y2 = y
		} else if parentFrame.elementDirection = horizontal {
			x1 = x
			y1 = parentFrame.frameAnchor[Y1] + spacing
			x2 = x
			y2 = parentFrame.frameAnchor[Y2] - spacing
		}
		draw_line_width(x1,y1,x2,y2,thickness)
		
		return adjustCursor(x,y)
	}
	
	adjustCursorX = function(x,y) {
		return [x + thickness / 2, y]
	}
	adjustCursorY = function(x,y) { // these seem inverted but it is correct.
		return [x, y + thickness / 2]
	}
}

function Padding(pad_x = unassigned, pad_y = unassigned) : Element(0) constructor {
	
	paddingX = pad_x
	paddingY = pad_y
	
	if parentFrame != unassigned {
		if paddingX = unassigned and parentFrame.elementStartDirection = horizontal {
			paddingX = parentFrame.elementPadding	
		}
		if paddingY = unassigned and parentFrame.elementStartDirection = vertical {
			paddingY = parentFrame.elementPadding	
		}
	}
	
	draw = function(x,y) {
	
		return [ x + paddingX, y + paddingY ]
	}
	
	onLink()
}

function Icon(size,color,thickness,sprite,index,image_scale = 1, blend = c_white, outline = true, _padding = unassigned) : Element(_padding) constructor {
	
	self.size = size
	self.color = color
	self.thickness = thickness
	self.sprite = sprite
	self.index = index
	self.blend = blend
	self.backgroundColor = colorSettings.icon
	self.outline = outline
	self.imageScale = image_scale
	
	draw = function(x, y) {
		
		realSize = min(size, parentFrame.paddedWidth, parentFrame.paddedHeight)
		
		spriteSize = realSize / sprite_get_width(sprite) * imageScale
		
		draw_set_color(backgroundColor)
		draw_circle(x + realSize / 2, y + realSize / 2, realSize / 2,false)
		
		if outline = true {
			draw_sprite_outline(sprite,index,x+2,y+2,spriteSize,spriteSize,0,c_black,1)
		}
		
		draw_sprite_ext(sprite,index,x + realSize * (1-imageScale) / 2 + 1,y + realSize * (1-imageScale) / 2 + 1,spriteSize,spriteSize,0,blend,1)

		return adjustCursor(x,y)
	}
	
	adjustCursorX = function(x, y) {
		return [x + realSize, y]
	}
	
	adjustCursorY = function(x, y) {
		return [x, y + realSize]
	}
	
}

function Dragger(thickness = 5, spacing = 0, _padding = 0) : Element(_padding) constructor {
	
	self.thickness = thickness
	self.spacing = spacing
	self.color = colorSettings.draggerIdle
	
	x1 = 0
	y1 = 0
	x2 = 0
	y2 = 0
	
	dragging = false
	
	drawColor = color
	
	draw = function(x,y) {
			
		draw_set_color(drawColor)
		if parentFrame.elementDirection = vertical {
			x1 = parentFrame.frameAnchor[X1] + spacing
			y1 = y + thickness / 2
			x2 = parentFrame.frameAnchor[X2] - spacing
			y2 = y + thickness / 2
		} else if parentFrame.elementDirection = horizontal {
			x1 = x - thickness / 2
			y1 = parentFrame.frameAnchor[Y1] + spacing
			x2 = x - thickness / 2
			y2 = parentFrame.frameAnchor[Y2] - spacing
		}
			
		draw_line_width(x1,y1,x2,y2,thickness)
		draw_circle(x1,y1,floor(thickness/2),false)
		draw_circle(x2,y2,floor(thickness/2),false)
		
		return adjustCursor(x,y)
	}
	
	run = function(value_to_change) {
		drawColor = color
		if point_in_rectangle(mouse_x,mouse_y,x1 - thickness,y1 - thickness,x2 + thickness, y2 + thickness) {
			drawColor = colorSettings.draggerActive
			
			if mouse_check_button_pressed(mb_left) {
				dragging = true
				startPos = parentFrame.elementDirection = vertical ? mouse_y : mouse_x
				startValue = value_to_change
			}
		}
		
		if dragging = true {
			if mouse_check_button_released(mb_left) {
				dragging = false
			}
			drawColor = colorSettings.draggerIdle
			
			return startValue + ((parentFrame.elementDirection = vertical ? mouse_y : mouse_x) - startPos)
		} else {
			return value_to_change
		}
	}
	
	adjustCursorX = function(x,y) {
		return [x + thickness, y]
	}
	adjustCursorY = function(x,y) {
		return [x, y + thickness]
	}
}

function LayoutSwitch(reset = false, layout = unassigned) : Element(0) constructor {
	
	self.layout = layout
	self.reset = reset

	draw = function(x,y) {
		
		// Single Line if statement.
		//parentFrame.elementDirection = (layout = unassigned ? (parentFrame.elementDirection = horizontal ? vertical : horizontal) : layout)
		if layout = unassigned {
			if parentFrame.elementDirection = horizontal {
				parentFrame.elementDirection = vertical
			} else {
				parentFrame.elementDirection = horizontal
			}
		} else {
			parentFrame.elementDirection = layout	
		}
		
		if parentFrame.elementDirection = vertical {
			//y = parentFrame.frameAnchor[Y1]
			if reset = true x = parentFrame.frameAnchor[X1]
		} else {
			//x = parentFrame.frameAnchor[X1]
			if reset = true y = parentFrame.frameAnchor[Y1]
		}
		
		return [x, y]
	}
}

function NotificationCircle(size = 12, _padding = unassigned) : Element(_padding) constructor {
		
	self.size = size
	self.activeColor = colorSettings.notification
	
	notifications = []
	
	addNotification = function(inputUser = noone, inputChannel = noone) {
		array_push(notifications, { user : inputUser, channel : inputChannel })	
	}
	
	draw = function(x, y) 
	{
		pos = move(x,y)
		var px = pos[X]
		var py = pos[Y]
		
		realSize = min(size, parentFrame.paddedWidth, parentFrame.paddedHeight)
		
		if array_length(notifications) > 0 {
			
			draw_set_color(activeColor)
			draw_circle(px + realSize / 2, py + realSize / 2, realSize/2, false)
			
		}
		
		return adjustCursor(x,y)
	}
	
	adjustCursorX = function(x, y) {
		return [x + (array_length(notifications) > 0 ? realSize : 0), y]
	}
	
	adjustCursorY = function(x, y) {
		return [x, y + (array_length(notifications) > 0 ? realSize : 0)]
	}
		
}
	
function Button(width = 50, height = 30, _padding = unassigned) : Element(_padding) constructor {
	
	self.width = width
	self.height = height
	
	x1 = 0
	y1 = 0
	x2 = 0
	y2 = 0
	
	draw = function(x,y) {
		
		x1 = x
		y1 = y
		x2 = x + width
		y2 = y + height
		
		draw_set_color(c_black)
		draw_rectangle(x1,y1,x2,y2,true)
		
		return adjustCursor(x,y)
	}
	
	run = function(value_to_change) {
		
		if point_in_rectangle(mouse_x,mouse_y,x1,y1,x2,y2)
		{
			
		}
		
	}
	
}

// Less General-Purpose Components (meant for AOLIM2 specifically) and also ones that inherit from the basic components.

function ColorFrame(width, height, color) : Frame(width, height) constructor {
	
	self.color = color
	
	drawSelf = function(x,y) {
		
		draw_set_color(color)
		
		var _ank = updateFrameAnchor(x,y)
		draw_rectangle(_ank[X1] + 1, _ank[Y1] + 1, _ank[X2] - 1, _ank[Y2] - 1, false)
	}
}

function Channel(name ,_padding = 4) : Frame(infinity,30,0,10,_padding) constructor {
				
	self.name = name
	timeSinceMessage = "10m ago"
				
	channelColor = c_black
	timeColor = c_gray
	
	elementStartDirection = horizontal
	
	margin = [5,0]
	drawSelf = function() {}
				
		notifications = new NotificationCircle()
		channelText = new TextElement("")
		timeText = new TextElement("")
	
	pop_element_scope()
	
	with notifications {
		move = function(x,y) {
			return [x, y + parentFrame.paddedHeight / 2 - size / 2]
		}	
	}

	with channelText {
		move = function(x,y) {
			return [x, y + parentFrame.paddedHeight / 2]
		}
	}
	with timeText {
		move = function(x,y) {
			return [parentFrame.frameAnchor[X2], parentFrame.frameAnchor[Y1] + parentFrame.paddedHeight / 2]
		}
	}
	
	step = function() {
					
		timeText.text = "[msdf_roboto][scale,1.3][fa_middle][fa_right]" + timeSinceMessage
		timeText.color = timeColor
					
		var _delete_pos =  floor((paddedWidth - 30) / 12.5)
		channelText.text = "[msdf_roboto][scale,1.6][fa_middle]" + string_delete(name,_delete_pos,10000)
		channelText.color = channelColor
		
	}
	
	addNotification = function(inputUser = noone, inputChannel = noone) {
		notifications.addNotification(inputUser,inputChannel)
	}
}

function ChatWindow(color = c_black) : Frame(infinity,infinity,5) constructor {
	
	self.color = color
	
	margin = [0, 0]
	
	elementStartDirection = vertical
		
		topFrame = new Frame(infinity,30,0,10,0)
		topFrame.drawSelf = function() {}
		topFrame.margin = [0, 0]
		topFrame.elementStartDirection = horizontal
		
			colorFrame = new ColorFrame(30,infinity,color)
			colorFrame.pop_element_scope()
			
			e = new Padding(-10,5)
				
				
			titleText = new TextElement("  topic: [[topic]")
			
		topFrame.pop_element_scope()
		
		e = new Divider()
		
	pop_element_scope()
}
	
function ChatMessage(user,message,time,compact = false) : Frame(infinity,32,0,10) constructor {
	
	self.user = user
	self.message = message
	self.time = time
	
	elementStartDirection = horizontal
	drawSelf = function() {}
	
		userIcon = new Icon(35,c_black,4,spr_portraits,user.portrait,1,user.color)
	
		// TODO: code to change the background color of these two following elements. will require a new frame.
		//topFrame.backgroundColor = topFrame.colorSettings.icon
		userName = new TextElement("[" + color_to_hex_string(user.color,0) + "]" + user.name)
		timeText = new TextElement(time.toString())
	
		e = new LayoutSwitch(true,vertical)
		e = new Padding(55,20)
	
		text = new TextElement(message)
		with text {
			draw = function(x,y) {
		
				pos = move(x,y)
		
				scribbleText = scribble(text).starting_format("fn_bahnscrift",colorSettings.text).animation_speed(0.5).wrap(parentFrame.frameAnchor[X2] - x - 15)
				scribbleText.draw(round(pos[X]),round(pos[Y]))
			
			
				parentFrame.idealHeight = (y - parentFrame.frameAnchor[Y1]) + scribbleText.get_height()
				return adjustCursor(x,y)
			}
		}
	
	pop_element_scope()
	
	e = new LayoutSwitch(true,vertical)
	
}
