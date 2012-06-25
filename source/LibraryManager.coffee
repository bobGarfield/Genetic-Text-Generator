class @LibraryManager

	# TODO: Add other alphabets support
	latinAlphabet = 'abcdefghijklmnopqrstuvwxyz'

	constructor : ->
		@library = ''
		@map     = {}

	init : (settings) ->
		{library, language, @limit} = settings

		@library  = library.replace(/[.!?,:;\-\n\'\"]+\s+/g, ' ').toLowerCase()
		@alphabet = switch language
			when 'latin' then latinAlphabet.split ''
			else null

		do @fillMap

	fillMap : ->
		{alphabet, map} = @

		alphabet.forEach (l1) =>
			alphabet.forEach (l2) =>
				alphabet.forEach (l3) =>
					triplet = "#{l1+l2+l3}"

					map[triplet] = @countOccurrence triplet

	randomLetter : ->
		return @alphabet.rand()

	generate : ->
		word = ''
	

		(@limit.rand()+@limit).times =>
			word += @randomLetter()

		return word

	countOccurrence : (string) ->
		number = @library.match(///#{string}///g)?.length or 0

		return number

	fitness : (word) ->
		{alphabet, map} = @

		fit = 0

		(word.length-2).times (i) =>
			sub = word[i..i+2]
			cnt = @map[sub]

			fit += cnt*cnt*10

		(word.length-1).times (i) =>
			sub = word[i..i+1]

			cnt = 0

			alphabet.forEach (l) ->	cnt += map["#{sub+l}"]

			fit += cnt

		return fit

	compare : (word1, word2) ->
		@fitness(word2) - @fitness(word1)

