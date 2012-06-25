class @GeneticManager
	constuctor : ->

	init : (settings) ->
		{@mutateRate} = settings

	crossover : (word1, word2) ->
		crossPoint = (word1.length).rand()

		child1 = word1[0..crossPoint]+word2[crossPoint+1...]
		child2 = word2[0..crossPoint]+word1[crossPoint+1...]

		return [child1, child2]

	mutate : (word, libraryManager) ->
		mutPoint = (word.length).rand()

		word[mutPoint] = libraryManager.randomLetter()

	crossMutate : (word1, word2, libraryManager) ->
		children = @crossover word1, word2

		if 100.rand() < @mutateRate
			@mutate(child, libraryManager) for child in children

		return children