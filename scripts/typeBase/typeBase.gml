// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function format_text(text)
{
	var tokens = []
	var _rippedString = string_copy(text,0,1000000)

	var _newToken;
	var _marker = 0
	var _length = string_length(_rippedString)
	for (var i = 0; i < _length; i ++)
	{
		var _char = string_char_at(_rippedString,i+1)
		if _char = " "
		{
			_newToken = string_copy(_rippedString,_marker+1,i-(_marker-1))
		
			array_push(tokens,_newToken)
		
			_marker = i+1
			continue
		}
		else if string_lettersdigits(_char) = ""
		{
			_newToken = string_copy(_rippedString,_marker+1,i-(_marker))
		
			array_push(tokens,_newToken)
			array_push(tokens,_char)
		
			_marker = i+1
			continue
		}
		else if i = _length - 1
		{
			_newToken = string_copy(_rippedString,_marker+1,1000)
		
			array_push(tokens,_newToken)
			continue
		}
	}	
	

	// FIXER
	for (var i = 0; i < array_length(tokens); i ++)
	{
		var _token = tokens[i]
		tokens[i] = ""
	
		for (var j = 0; j < string_length(_token); j ++)
		{
		
			var _char = string_char_at(_token,j+1)
	
			switch _char
			{
				case "[":
					tokens[i] += "[["
					break
				default:
					tokens[i] += _char
			}
		}
	}
	//*/

	// DECORATOR
	var _quotationsClosed = true
	var _commentClosed = true
	var _emojiOpen
	for (var i = 0; i < array_length(tokens); i ++)
	{
		var _token = string_replace(tokens[i]," ","")
		if _token = "" continue
		if _token = "\t" continue
	
	
		if _token = "#" {
			tokens[i] = "[" + color_to_hex_string(paintIndex[$ "comment color"]) + "]" + tokens[i]
			_commentClosed = not _commentClosed
		} else
		if _commentClosed = false {
			tokens[i] = "[" + color_to_hex_string(paintIndex[$ "comment color"]) + "]" + tokens[i]
		} else
	
	
		if _token = "\"" {
			tokens[i] = "[" + color_to_hex_string(paintIndex[$ "quotation color"]) + "]" + tokens[i]
			_quotationsClosed = not _quotationsClosed
		} else
		if _quotationsClosed = false {
			tokens[i] = "[" + color_to_hex_string(paintIndex[$ "quotation color"]) + "]" + tokens[i]	
		} else
	
	
		if variable_struct_exists(paintIndex, _token) {
			tokens[i] = "[" + color_to_hex_string(paintIndex[$ _token]) + "]" + tokens[i]
		} else if string_digits(_token) = _token  {
			tokens[i] = "[" + color_to_hex_string(paintIndex[$ "digit color"]) + "]" + tokens[i]
		} else {
			tokens[i] = "[" + color_to_hex_string(paintIndex[$ "default color"]) + "]" + tokens[i]
		}
	}



	// TAPER
	var finalString = ""
	for (var i = 0; i < array_length(tokens); i ++)
	{
		finalString += tokens[i]	
	}
	
	return finalString
}