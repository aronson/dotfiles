# Order 1 Markov chain
class BaseMarkovChain
  include Enumerable

  attr_reader :start, :end

  def initialize
    @states = {}
    @start = Object.new.freeze
    @end = Object.new.freeze
  end

  # Add a transition (or modify its weight)
  # States are created implicitly
  def add_transition(from, to, weight=1)
    weight = weight.to_int
    return if weight.zero?

    weights = @states[from] ||= Hash.new(0)
    new_weight = weights[to] + weight

    if new_weight > 0
      weights[to] = new_weight
    elsif new_weight.zero?
      weights.delete(to)
      @states.delete(from) if weights.empty?
    else
      raise ArgumentError, "A transition weight must not become negative"
    end
  end

  # Add a series of transitions through the chain
  # Implicitly adds start and end
  def add_transitions(enum, weight=1)
    e = Enumerator.new do |y|
      y.yield @start
      enum.each { |o| y.yield o }
      y.yield @end
    end

    e.each_cons(2) do |from, to|
      add_transition from, to, weight
    end

    return nil
  end

  def states
    @states.keys
  end

  def next(from=@start)
    weights = @states[from]
    raise ArgumentError, "State '#{from}' does not exist in chain #{inspect}" if weights.nil?

    target = rand(weights.values.inject(:+))

    weights.each do |to, weight|
      target -= weight
      return to if target < 0
    end
  end

  # Transit through the chain from start to end
  # Returning each state encountered
  def each_state
    return enum_for(__method__) unless block_given?

    previous = @start
    loop do
      state = self.next(previous)
      break if state == @end
      yield state
      previous = state
    end
  end

  # Transit through the chain from start to end
  # Returning each output produced
  alias_method :each_output, :each_state

  # each is an alias for each_output, even in subclasses
  def each(&block)
    each_output(&block)
  end

  def stats
    s = @states.size
    t = @states.values.map(&:size).inject(:+)
    ["States: #{s}", "Transitions: #{t}", "T/S: #{t/Float(s)}"]
  end

  def inspect
    "#<#{self.class} #{stats.join ", "}>"
  end

  alias_method :to_s, :inspect
end
