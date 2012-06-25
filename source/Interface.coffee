# Singleton
class @Interface

	## Private
	show = (element) ->
		element.style.display = 'block'

	hide = (element) ->
		element.style.display = 'none'

	$ = (selector) ->
		return document.querySelector selector

	controller = null

	## Public
	constructor : (hash) ->
		@parts = {}

		for key of hash
			@parts[key] = $ hash[key]

	init : (c) ->
		controller = c

		do @bindEvents

	bindEvents : ->
		{confirm, next, library, output, generator, calibrator} = @parts

		confirm.onclick = ->
			hide calibrator
			show generator

			controller.init
				library        : library.innerText
				language       : 'latin'
				populationSize : 100
				limit          : 5
				mutateRate     : 25
				
		evolve = ->
			do controller.evolve
		
			output.innerText  = ""
			output.innerText += "Generation : #{controller.generation}\n"
			output.innerText += "Alpha      : #{controller.alphas}\n"
			
		process = {}
			
		set = ->
			process = setInterval evolve, 1000/25
			
			next.onclick = unset
		
		unset = ->
			clearInterval process
			
			next.onclick = set

		next.onclick = ->				
			do set
		
					
				
