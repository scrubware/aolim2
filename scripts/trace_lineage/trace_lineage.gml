function trace_lineage(id) {
	
	var traceList = [id]
	
	var tracer = id
	while tracer.parentFrame != unassigned {
		tracer = tracer.parentFrame
		array_insert(traceList,0,tracer)
	}
	
	
	
	var cursor = [0,0,0,0]
	for ( var i = 0; i < array_length(traceList) - 1; i ++) {
		cursor = traceList[i].traceCursor(cursor[0],cursor[1],traceList[i+1])
	}
	
	return cursor
}