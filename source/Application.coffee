{Interface, Controller} = @

class @Application

	constructor : ->
		ui = new Interface
			# Sections
			calibrator : '#calibrator'
			generator  : '#generator'

			# Parts
			library : '#library'
			output  : '#output'

			# Buttons
			confirm : '#confirm'
			next    : '#next'

		controller = new Controller ui

		ui.init controller


