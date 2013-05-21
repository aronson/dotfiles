require 'markov_chain'

# Simple Generator reading/producing sequences of tokens
# into/from a Markov chain of specified order
class BaseGenerator
  include Enumerable

  def initialize(order)
    @chain = MarkovChain.new(order)
  end

  # Read a sequence of tokens and add transitions to the chain
  def analyze(tokens)
    @chain.add_transitions tokens
  end

  # Produce a single token sequence
  def next
    @chain.each.to_a
  end

  # Produce an infinite series of sequences
  def each
    return enum_for(__method__) unless block_given?

    loop do
      yield self.next
    end
  end

  def stats
    @chain.stats
  end
end

# Generator using strings, splitting them into chars as tokens
class BaseCharacterGenerator < BaseGenerator
  def analyze(text)
    super text.each_char
  end

  def next
    super.join ""
  end
end

# Generator using strings, splitting them into words as tokens
class BaseWordGenerator < BaseGenerator
  def analyze(text)
    super text.split
  end

  def next
    super.join " "
  end
end
