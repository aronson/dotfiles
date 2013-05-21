all: neo2 neo3 neo4 neo5 neo6 text-s7 text-t2

neo2: analyze txt/words/*.txt lib/*.rb lib/markov_chain/*.rb lib/generators/*.rb
	cat txt/words/*.txt | ./analyze Neologism 2 > neo2
neo3: analyze txt/words/*.txt lib/*.rb lib/markov_chain/*.rb lib/generators/*.rb
	cat txt/words/*.txt | ./analyze Neologism 3 > neo3
neo4: analyze txt/words/*.txt lib/*.rb lib/markov_chain/*.rb lib/generators/*.rb
	cat txt/words/*.txt | ./analyze Neologism 4 > neo4
neo5: analyze txt/words/*.txt lib/*.rb lib/markov_chain/*.rb lib/generators/*.rb
	cat txt/words/*.txt | ./analyze Neologism 5 > neo5
neo6: analyze txt/words/*.txt lib/*.rb lib/markov_chain/*.rb lib/generators/*.rb
	cat txt/words/*.txt | ./analyze Neologism 6 > neo6
text-s7: analyze txt/texts/*.txt lib/*.rb lib/markov_chain/*.rb lib/generators/*.rb
	cat txt/texts/*.txt | ./analyze Sentence 7 > text-s7
text-t2: analyze txt/texts/*.txt lib/*.rb lib/markov_chain/*.rb lib/generators/*.rb
	cat txt/texts/*.txt | ./analyze Text 2 > text-t2

.PHONY: all
