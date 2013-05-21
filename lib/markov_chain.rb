# Autoload default implementation
require 'markov_chain/hash' unless defined?(BaseMarkovChain)

# Higher order markov chain
class MarkovChain < BaseMarkovChain
  attr_reader :order

  def initialize(order)
    order >= 1 or raise ArgumentError, "order must be >= 1"
    super()
    @order = order
  end

  # Add higher-order transitions
  def add_transitions(enum, weight=1)
    # Prepend a few nils
    e = Enumerator.new do |y|
      (@order - 1).times { y.yield nil }
      enum.each { |o| y.yield o }
    end

    super e.each_cons(@order), weight
  end

  def each_output
    return enum_for(__method__) unless block_given?

    states = each_state

    # Yield only the last element from each state
    loop do
      yield states.next.last
    end
  end

  def inspect
    "#<#{self.class} Order: #{@order}, #{stats.join ", "}>"
  end

  alias_method :to_s, :inspect
end
