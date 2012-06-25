Number::times = (step, callback) ->
	unless callback
		callback = step
		step     = 1
		
	callback(i) for i in [0...@] by step
	return

Number::rand = ->
	return Math.floor(Math.random(@)*@)

Array::rand = ->
	return @[@length.rand()]

Function::get = (property, callback) ->
	@::__defineGetter__ property, callback
	
Function::set = (property, callback) ->
	@::__defineSetter__ property, callback
