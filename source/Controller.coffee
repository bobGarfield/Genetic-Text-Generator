{LibraryManager, GeneticManager} = @

# Singleton
class @Controller

	## Private
	ui = null

	## Public
	constructor : (wui) ->
		ui = wui

		@population = []
		@alphas     = []

		@libraryManager = new LibraryManager
		@geneticManager = new GeneticManager
		
		@generation = 0

	init : (settings) ->
		{@populationSize} = settings
		{population, geneticManager, libraryManager} = @

		libraryManager.init settings
		geneticManager.init settings

		@populationSize.times (i) -> population[i] = libraryManager.generate()
			
	reset : ->
		@generation = 0
		
		@alphas.push "\n#{@population[0]}"
		
		@populationSize.times (i) => @population[i] = @libraryManager.generate()

	evolve : ->
		{population, geneticManager, libraryManager} = @
		
		@generation++
		
		hpopulationSize = @populationSize/2
		nextPopulation  = []

		(@populationSize).times 2, (i) ->
			child1 = ''
			child2 = ''

			children = geneticManager.crossMutate population[hpopulationSize.rand()], population[hpopulationSize.rand()], libraryManager

			nextPopulation[i]   = children[0]
			nextPopulation[i+1] = children[1]

		@population = nextPopulation
		
		do @sortPopulation
		
		@reset() if @generation is 40

	sortPopulation : ->
		@population.sort (one, two) =>
			@libraryManager.compare one, two
			
	@get 'alpha', ->
		return @population[0]
		
	
	